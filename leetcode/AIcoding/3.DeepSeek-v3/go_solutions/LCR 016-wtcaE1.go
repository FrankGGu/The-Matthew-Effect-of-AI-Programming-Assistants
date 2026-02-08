func lengthOfLongestSubstring(s string) int {
    charIndex := make(map[byte]int)
    maxLen := 0
    left := 0

    for right := 0; right < len(s); right++ {
        if index, found := charIndex[s[right]]; found {
            if index >= left {
                left = index + 1
            }
        }
        charIndex[s[right]] = right
        currentLen := right - left + 1
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }

    return maxLen
}