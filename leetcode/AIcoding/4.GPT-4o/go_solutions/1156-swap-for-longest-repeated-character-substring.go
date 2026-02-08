func characterReplacement(s string, k int) int {
    count := make([]int, 26)
    left, maxCount, maxLength := 0, 0, 0

    for right := 0; right < len(s); right++ {
        count[s[right]-'A']++
        maxCount = max(maxCount, count[s[right]-'A'])

        for right-left+1-maxCount > k {
            count[s[left]-'A']--
            left++
        }
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