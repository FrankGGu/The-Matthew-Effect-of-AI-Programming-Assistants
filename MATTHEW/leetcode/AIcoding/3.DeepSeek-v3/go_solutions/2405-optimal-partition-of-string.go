func partitionString(s string) int {
    lastSeen := make([]int, 26)
    for i := range lastSeen {
        lastSeen[i] = -1
    }
    count := 1
    start := 0
    for i, ch := range s {
        idx := int(ch - 'a')
        if lastSeen[idx] >= start {
            count++
            start = i
        }
        lastSeen[idx] = i
    }
    return count
}