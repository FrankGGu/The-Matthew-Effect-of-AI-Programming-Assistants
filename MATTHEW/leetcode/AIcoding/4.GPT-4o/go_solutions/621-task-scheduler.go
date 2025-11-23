func leastInterval(tasks []byte, n int) int {
    count := make([]int, 26)
    for _, task := range tasks {
        count[task-'A']++
    }

    maxCount := 0
    maxFreq := 0
    for _, c := range count {
        if c > maxCount {
            maxCount = c
            maxFreq = 1
        } else if c == maxCount {
            maxFreq++
        }
    }

    partCount := maxCount - 1
    partLength := n - (maxFreq - 1)
    emptySlots := partCount * partLength
    availableTasks := len(tasks) - maxCount * maxFreq
    idles := max(0, emptySlots-availableTasks)

    return len(tasks) + idles
}