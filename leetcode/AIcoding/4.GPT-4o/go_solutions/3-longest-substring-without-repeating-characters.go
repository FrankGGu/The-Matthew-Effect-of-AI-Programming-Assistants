func lengthOfLongestSubstring(s string) int {
    charMap := make(map[byte]int)
    left, maxLength := 0, 0

    for right := 0; right < len(s); right++ {
        if index, found := charMap[s[right]]; found && index >= left {
            left = index + 1
        }
        charMap[s[right]] = right
        maxLength = max(maxLength, right-left+1)
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}