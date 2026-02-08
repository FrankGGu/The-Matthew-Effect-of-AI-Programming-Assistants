func findTheLongestBalancedSubstring(s string) int {
    maxLen := 0
    n := len(s)
    for i := 0; i < n; {
        if s[i] == '0' {
            zeroCount := 0
            for i < n && s[i] == '0' {
                zeroCount++
                i++
            }
            oneCount := 0
            j := i
            for j < n && s[j] == '1' {
                oneCount++
                j++
            }
            balancedLen := 2 * min(zeroCount, oneCount)
            if balancedLen > maxLen {
                maxLen = balancedLen
            }
            i = j
        } else {
            i++
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