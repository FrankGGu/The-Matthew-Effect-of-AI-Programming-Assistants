type TaskManager struct {
    tasks map[int]int
}

func Constructor() TaskManager {
    return TaskManager{
        tasks: make(map[int]int),
    }
}

func (this *TaskManager) AddTask(id int, executionTime int) {
    this.tasks[id] = executionTime
}

func (this *TaskManager) CancelTask(id int) bool {
    if _, exists := this.tasks[id]; exists {
        delete(this.tasks, id)
        return true
    }
    return false
}

func (this *TaskManager) ExecuteTasks(currentTime int) []int {
    var executed []int
    for id, execTime := range this.tasks {
        if execTime <= currentTime {
            executed = append(executed, id)
            delete(this.tasks, id)
        }
    }
    sort.Ints(executed)
    return executed
}