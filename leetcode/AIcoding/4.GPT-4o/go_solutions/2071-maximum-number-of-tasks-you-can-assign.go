func maxTasksAssign(tasks []int, workers []int, maxTime int) int {
    sort.Ints(tasks)
    sort.Ints(workers)

    left, right := 0, len(tasks)
    for left < right {
        mid := (left + right + 1) / 2
        if canAssign(tasks[:mid], workers, maxTime) {
            left = mid
        } else {
            right = mid - 1
        }
    }

    return left
}

func canAssign(tasks []int, workers []int, maxTime int) bool {
    n := len(tasks)
    if n > len(workers) {
        return false
    }

    taskIndex, workerIndex := 0, 0
    for workerIndex < len(workers) && taskIndex < n {
        if workers[workerIndex] >= tasks[taskIndex] {
            taskIndex++
        }
        workerIndex++
    }

    return taskIndex == n
}