func minimumValidStrings(words []string, target string) int {
    n := len(target)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for _, word := range words {
        for i := n; i >= 0; i-- {
            if dp[i] == math.MaxInt32 {
                continue
            }
            pos := i
            for j := 0; j < len(word) && pos < n; j++ {
                if word[j] == target[pos] {
                    pos++
                }
            }
            if dp[pos] > dp[i]+1 {
                dp[pos] = dp[i] + 1
            }
        }
    }

    if dp[n] == math.MaxInt32 {
        return -1
    }
    return dp[n]
}