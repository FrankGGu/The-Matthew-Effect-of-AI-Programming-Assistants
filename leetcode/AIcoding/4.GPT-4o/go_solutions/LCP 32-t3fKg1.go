func processTasks(tasks []int, n int) int {
    taskCount := make(map[int]int)
    for _, task := range tasks {
        taskCount[task]++
    }

    maxFreq := 0
    for _, count := range taskCount {
        if count > maxFreq {
            maxFreq = count
        }
    }

    maxCount := 0
    for _, count := range taskCount {
        if count == maxFreq {
            maxCount++
        }
    }

    intervals := (maxFreq - 1) * (n + 1) + maxCount
    if intervals < len(tasks) {
        return len(tasks)
    }
    return intervals
}