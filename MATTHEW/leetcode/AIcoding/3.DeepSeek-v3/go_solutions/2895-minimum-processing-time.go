import "sort"

func minProcessingTime(processorTime []int, tasks []int) int {
    sort.Ints(processorTime)
    sort.Ints(tasks)
    n := len(processorTime)
    res := 0
    for i := 0; i < n; i++ {
        maxTime := processorTime[i] + tasks[4*n-1 - 4*i]
        if maxTime > res {
            res = maxTime
        }
    }
    return res
}