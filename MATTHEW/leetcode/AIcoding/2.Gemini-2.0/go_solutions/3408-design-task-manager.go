type TaskManager struct {
    tasks map[int]int
    available int
}

func Constructor(n int) TaskManager {
    return TaskManager{
        tasks: make(map[int]int),
        available: 1,
    }
}

func (this *TaskManager) AddTask(taskId int) {
    this.tasks[this.available] = taskId
    this.available++
}

func (this *TaskManager) RemoveTask(taskId int) bool {
    for k, v := range this.tasks {
        if v == taskId {
            delete(this.tasks, k)
            return true
        }
    }
    return false
}

func (this *TaskManager) Run() int {
    if len(this.tasks) == 0 {
        return -1
    }
    minKey := -1
    for k := range this.tasks {
        if minKey == -1 || k < minKey {
            minKey = k
        }
    }
    taskId := this.tasks[minKey]
    delete(this.tasks, minKey)
    return taskId
}