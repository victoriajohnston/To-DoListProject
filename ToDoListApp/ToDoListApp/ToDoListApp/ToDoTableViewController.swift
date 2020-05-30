//
//  ToDoTableViewController.swift
//  ToDoListApp
//
//  Created by gwc on 5/29/20.
//  Copyright © 2020 gwc. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var toDos: [ToDoCD] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func getToDos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                toDos = coreDataToDos
                tableView.reloadData()
            }
        }
    }
    /*func createToDos() -> [ToDo] {
        let swift = ToDo()
        swift.name = "Learn Swift 😎"
        swift.important = true
        
        let dog = ToDo()
        dog.name = "Walk my Dog, Roxy 💕"
        
        let clean = ToDo()
        clean.name = "Clean my room 😅"
        return [swift, dog, clean]
    }*/
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
        
        if toDo.important{
            cell.textLabel?.text = "🔥" + toDo.name
        } else {
            cell.textLabel?.text = "👀" + toDo.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self;
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD{
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }

}
