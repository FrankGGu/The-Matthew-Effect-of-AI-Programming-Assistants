func dismantlingAction(arr string) int {
    lastOccurred := make(map[rune]int)
    start := 0
    maxLength := 0

    for i, ch := range arr {
        if lastIdx, ok := lastOccurred[ch]; ok && lastIdx >= start {
            start = lastIdx + 1
        }
        lastOccurred[ch] = i
        if i - start + 1 > maxLength {
            maxLength = i - start + 1
        }
    }

    return maxLength
}