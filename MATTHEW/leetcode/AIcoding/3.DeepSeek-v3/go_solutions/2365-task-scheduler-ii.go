func taskSchedulerII(tasks []int, space int) int64 {
    lastDay := make(map[int]int64)
    currentDay := int64(0)
    for _, task := range tasks {
        currentDay++
        if prevDay, exists := lastDay[task]; exists {
            if currentDay - prevDay <= int64(space) {
                currentDay = prevDay + int64(space) + 1
            }
        }
        lastDay[task] = currentDay
    }
    return currentDay
}