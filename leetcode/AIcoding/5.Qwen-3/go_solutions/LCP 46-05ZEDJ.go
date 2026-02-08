package main

func minTasks(tasks []int, workers []int) int {
    sort.Ints(tasks)
    sort.Ints(workers)
    i := len(tasks) - 1
    j := len(workers) - 1
    res := 0
    for i >= 0 && j >= 0 {
        if tasks[i] <= workers[j] {
            i--
            j--
        } else {
            j--
        }
        res++
    }
    return res
}