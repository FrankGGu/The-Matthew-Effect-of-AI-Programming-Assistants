func leastInterval(tasks []byte, n int) int {
    count := make([]int, 26)
    for _, task := range tasks {
        count[task-'A']++
    }

    maxCount := 0
    maxFrequency := 0
    for _, c := range count {
        if c > maxCount {
            maxCount = c
            maxFrequency = 1
        } else if c == maxCount {
            maxFrequency++
        }
    }

    parts := maxCount - 1
    emptySlots := parts * n
    availableTasks := len(tasks) - maxCount * maxFrequency
    idles := max(0, emptySlots - availableTasks)

    return len(tasks) + idles
}