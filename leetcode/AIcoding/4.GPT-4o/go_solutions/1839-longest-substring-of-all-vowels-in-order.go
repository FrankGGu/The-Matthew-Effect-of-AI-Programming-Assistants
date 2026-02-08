func longestVowelSubstring(s string) int {
    vowels := "aeiou"
    maxLength := 0
    currentLength := 0
    lastIndex := -1

    for i, char := range s {
        idx := strings.IndexByte(vowels, byte(char))
        if idx == -1 {
            currentLength = 0
            lastIndex = -1
        } else {
            if lastIndex == -1 || idx == lastIndex+1 {
                currentLength++
            } else if idx == 0 {
                currentLength = 1
            } else {
                currentLength = 0
            }
            lastIndex = idx
            maxLength = max(maxLength, currentLength)
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}