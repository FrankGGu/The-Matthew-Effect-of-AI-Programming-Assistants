func longestBeautifulSubstring(word string) int {
    maxLen := 0
    currentLen := 1
    uniqueCount := 1

    for i := 1; i < len(word); i++ {
        if word[i] > word[i-1] {
            currentLen++
            uniqueCount++
        } else if word[i] == word[i-1] {
            currentLen++
        } else {
            currentLen = 1
            uniqueCount = 1
        }

        if uniqueCount == 5 && currentLen > maxLen {
            maxLen = currentLen
        }
    }

    return maxLen
}