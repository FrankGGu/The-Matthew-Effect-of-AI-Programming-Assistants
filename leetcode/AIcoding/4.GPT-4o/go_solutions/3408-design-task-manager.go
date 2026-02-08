type TaskManager struct {
    tasks       map[int]int
    available   []int
    currentTime int
}

func Constructor() TaskManager {
    return TaskManager{
        tasks:     make(map[int]int),
        available: []int{},
        currentTime: 0,
    }
}

func (tm *TaskManager) AddTask(duration int) {
    tm.tasks[tm.currentTime] = duration
    tm.available = append(tm.available, tm.currentTime)
    tm.currentTime++
}

func (tm *TaskManager) RunTask() int {
    if len(tm.available) == 0 {
        return -1
    }
    nextTaskIdx := 0
    for i := 1; i < len(tm.available); i++ {
        if tm.tasks[tm.available[i]] < tm.tasks[tm.available[nextTaskIdx]] {
            nextTaskIdx = i
        }
    }
    taskTime := tm.available[nextTaskIdx]
    tm.available = append(tm.available[:nextTaskIdx], tm.available[nextTaskIdx+1:]...)
    return taskTime
}

func (tm *TaskManager) CompleteTask(taskId int) {
    delete(tm.tasks, taskId)
}