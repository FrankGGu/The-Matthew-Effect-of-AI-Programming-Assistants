func leastInterval(tasks []byte, n int) int {
    freq := make([]int, 26)
    for _, task := range tasks {
        freq[task-'A']++
    }
    sort.Ints(freq)
    maxFreq := freq[25]
    idleSlots := (maxFreq - 1) * n

    for i := 24; i >= 0 && freq[i] > 0; i-- {
        idleSlots -= min(freq[i], maxFreq-1)
    }

    if idleSlots > 0 {
        return idleSlots + len(tasks)
    }
    return len(tasks)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}