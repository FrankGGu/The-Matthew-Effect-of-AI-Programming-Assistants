func lengthOfLongestSubstring(s string) int {
    charIndexMap := make(map[rune]int)
    maxLength := 0
    left := 0

    for right, char := range s {
        if prevIndex, found := charIndexMap[char]; found && prevIndex >= left {
            left