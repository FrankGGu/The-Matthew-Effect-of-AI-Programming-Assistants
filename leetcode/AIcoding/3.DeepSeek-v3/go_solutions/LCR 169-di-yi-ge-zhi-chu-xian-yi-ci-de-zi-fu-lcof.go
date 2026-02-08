func dismantlingAction(arr string) int {
    lastOccurrence := make(map[rune]int)
    maxLength := 0
    start := 0

    for end, ch := range arr {
        if lastIndex, exists := lastOccurrence[ch]; exists && lastIndex >= start {
            start = lastIndex + 1
        }
        lastOccurrence[ch] = end
        currentLength := end - start + 1
        if currentLength > maxLength {
            maxLength = currentLength
        }
    }

    return maxLength
}