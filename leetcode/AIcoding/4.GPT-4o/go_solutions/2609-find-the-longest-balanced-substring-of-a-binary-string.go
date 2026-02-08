func findTheLongestBalancedSubstring(s string) int {
    maxLen := 0
    count0, count1 := 0, 0

    for i := 0; i < len(s); i++ {
        if s[i] == '0' {
            count0++
            if count1 > 0 {
                maxLen = max(maxLen, 2*min(count0, count1))
            }
        } else {
            count1++
            if count0 > 0 {
                maxLen = max(maxLen, 2*min(count0, count1))
            }
        }
    }

    return maxLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}