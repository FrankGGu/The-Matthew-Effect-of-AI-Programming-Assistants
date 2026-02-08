func longestSubstring(s string, k int) int {
    n := len(s)
    if n == 0 || k > n {
        return 0
    }

    charCount := make(map[rune]int)
    for _, char := range s {
        charCount[char]++
    }

    for char, count := range charCount {
        if count < k {
            maxLen := 0
            for _, substr := range strings.Split(s, string(char)) {
                maxLen = max(maxLen, longestSubstring(substr, k))
            }
            return maxLen
        }
    }
    return n
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}