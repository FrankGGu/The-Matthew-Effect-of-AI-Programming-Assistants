func findMinimumTime(tasks [][]int) int {
    sort.Slice(tasks, func(i, j int) bool {
        return tasks[i][1] < tasks[j][1]
    })

    used := make([]bool, 2001)
    res := 0

    for _, task := range tasks {
        start, end, duration := task[0], task[1], task[2]
        for t := start; t <= end; t++ {
            if used[t] {
                duration--
            }
        }
        for t := end; duration > 0; t-- {
            if !used[t] {
                used[t] = true
                duration--
                res++
            }
        }
    }

    return res
}