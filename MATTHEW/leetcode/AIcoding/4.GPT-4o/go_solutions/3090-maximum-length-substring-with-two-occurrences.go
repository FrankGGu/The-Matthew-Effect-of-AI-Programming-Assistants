func maximumLengthSubstring(s string) int {
    maxLength := 0
    count := make(map[rune]int)
    left := 0

    for right, char := range s {
        count[char]++

        for len(count) > 2 {
            count[rune(s[left])]--
            if count[rune(s[left])] == 0 {
                delete(count, rune(s[left]))
            }
            left++
        }

        if len(count) == 2 {
            maxLength = max(maxLength, right-left+1)
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