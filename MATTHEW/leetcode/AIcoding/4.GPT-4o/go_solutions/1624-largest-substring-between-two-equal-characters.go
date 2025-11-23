func maxLengthBetweenEqualCharacters(s string) int {
    index := make(map[byte]int)
    maxLength := -1

    for i := 0; i < len(s); i++ {
        if idx, exists := index[s[i]]; exists {
            maxLength = max(maxLength, i-idx-1)
        } else {
            index[s[i]] = i
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