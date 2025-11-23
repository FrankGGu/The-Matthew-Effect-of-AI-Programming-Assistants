package main

func processTasks(tasks []int, k int) int {
    n := len(tasks)
    if n == 0 {
        return 0
    }
    res := 0
    for i := 0; i < n; i++ {
        if tasks[i] > k {
            res++
        }
    }
    return res
}