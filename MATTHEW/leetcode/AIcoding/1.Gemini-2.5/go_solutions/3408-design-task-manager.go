type TaskStatus int

const (
	TaskStatusPending TaskStatus = iota
	TaskStatusCompleted
)

type Task struct {
	ID          int
	Priority    int
	Description string
	Status      TaskStatus
}

type TaskManager struct {
	tasks map[int]*Task
}

func Constructor() TaskManager {
	return TaskManager{
		tasks: make(map[int]*Task),
	}
}

func (tm *TaskManager) AddTask(taskID int, priority int, description string) bool {
	if _, exists := tm.tasks[taskID]; exists {
		return false
	}
	tm.tasks[taskID] = &Task{
		ID:          taskID,
		Priority:    priority,
		Description: description,
		Status:      TaskStatusPending,
	}
	return true
}

func (tm *TaskManager) GetTask(taskID int) *Task {
	if task, exists := tm.tasks[taskID]; exists {
		return task
	}
	return nil
}

func (tm *TaskManager) UpdateTaskPriority(taskID int, newPriority int) bool {
	if task, exists := tm.tasks[taskID]; exists {
		task.Priority = newPriority
		return true
	}
	return false
}

func (tm *TaskManager) CompleteTask(taskID int) bool {
	if task, exists := tm.tasks[taskID]; exists {
		task.Status = TaskStatusCompleted
		return true
	}
	return false
}

func (tm *TaskManager) RemoveTask(taskID int) bool {
	if _, exists := tm.tasks[taskID]; exists {
		delete(tm.tasks, taskID)
		return true
	}
	return false
}

func (tm *TaskManager) ListAllTasks() []*Task {
	tasks := make([]*Task, 0, len(tm.tasks))
	for _, task := range tm.tasks {
		tasks = append(tasks, task)
	}
	return tasks
}

func (tm *TaskManager) ListPendingTasks() []*Task {
	pendingTasks := make([]*Task, 0, len(tm.tasks))
	for _, task := range tm.tasks {
		if task.Status == TaskStatusPending {
			pendingTasks = append(pendingTasks, task)
		}
	}
	return pendingTasks
}