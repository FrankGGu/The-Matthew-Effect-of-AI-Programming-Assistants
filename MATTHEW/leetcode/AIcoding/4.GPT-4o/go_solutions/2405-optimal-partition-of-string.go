func partitionString(s string) int {
    lastSeen := make(map[rune]int)
    count := 0
    start := 0

    for i, char := range s {
        if lastIndex, found := lastSeen[char]; found && lastIndex >= start {
            count++
            start = i
        }
        lastSeen[char] = i
    }

    return count + 1
}