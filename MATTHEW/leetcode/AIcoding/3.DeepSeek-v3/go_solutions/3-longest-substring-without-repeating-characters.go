func lengthOfLongestSubstring(s string) int {
    charIndex := make(map[byte]int)
    maxLen := 0
    start := 0

    for end := 0; end < len(s); end++ {
        if idx, exists := charIndex[s[end]]; exists && idx >= start {
            start = idx + 1
        }
        charIndex[s[end]] = end
        currentLen := end - start + 1
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }

    return maxLen
}