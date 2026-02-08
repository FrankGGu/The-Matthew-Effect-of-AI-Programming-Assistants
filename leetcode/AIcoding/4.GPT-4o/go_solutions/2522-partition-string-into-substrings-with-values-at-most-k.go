func partitionString(s string, k int) int {
    lastSeen := make(map[rune]int)
    count := 0
    start := 0

    for i, char := range s {
        if pos, ok := lastSeen[char]; ok && pos >= start {
            start = pos + 1
        }
        lastSeen[char] = i
        if len(lastSeen) > k {
            count++
            lastSeen = make(map[rune]int)
            lastSeen[char] = i
            start = i
        }
    }
    return count + 1
}