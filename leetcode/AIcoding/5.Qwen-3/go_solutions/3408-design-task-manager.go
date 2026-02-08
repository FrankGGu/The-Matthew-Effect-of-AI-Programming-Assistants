package main

type Task struct {
    Id      int
    Name    string
    Status  string
}

type TaskManager struct {
    tasks map[int]Task
    nextId int
}

func Constructor() TaskManager {
    return TaskManager{
        tasks: make(map[int]Task),
        nextId: 1,
    }
}

func (tm *TaskManager) AddTask(name string) int {
    taskId := tm.nextId
    tm.tasks[taskId] = Task{
        Id:     taskId,
        Name:   name,
        Status: "Pending",
    }
    tm.nextId++
    return taskId
}

func (tm *TaskManager) UpdateTaskStatus(id int, status string) bool {
    task, exists := tm.tasks[id]
    if !exists {
        return false
    }
    task.Status = status
    tm.tasks[id] = task
    return true
}

func (tm *TaskManager) GetTask(id int) (Task, bool) {
    task, exists := tm.tasks[id]
    return task, exists
}

func (tm *TaskManager) GetAllTasks() []Task {
    tasks := make([]Task, 0, len(tm.tasks))
    for _, task := range tm.tasks {
        tasks = append(tasks, task)
    }
    return tasks
}