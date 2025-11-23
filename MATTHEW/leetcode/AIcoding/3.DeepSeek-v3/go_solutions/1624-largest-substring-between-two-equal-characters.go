func maxLengthBetweenEqualCharacters(s string) int {
    firstOccurrence := make(map[rune]int)
    maxLen := -1

    for i, ch := range s {
        if firstIdx, exists := firstOccurrence[ch]; exists {
            currentLen := i - firstIdx - 1
            if currentLen > maxLen {
                maxLen = currentLen
            }
        } else {
            firstOccurrence[ch] = i
        }
    }

    return maxLen
}