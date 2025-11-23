func lengthOfLongestSubstring(s string) int {
    charMap := make(map[byte]int)
    left, maxLength := 0, 0

    for right := 0; right < len(s); right++ {
        if idx, found := charMap[s[right]]; found && idx >= left {
            left = idx + 1
        }
        charMap[s[right]] = right
        if maxLength < right-left+1 {
            maxLength = right - left + 1
        }
    }
    return maxLength
}