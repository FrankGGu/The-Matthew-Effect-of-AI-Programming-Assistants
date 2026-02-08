func minDeletionSize(strs []string) int {
    m, n := len(strs), len(strs[0])
    dp := make([]int, n)
    max := 1
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            valid := true
            for k := 0; k < m; k++ {
                if strs[k][j] > strs[k][i] {
                    valid = false
                    break
                }
            }
            if valid && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
            }
        }
        if dp[i] > max {
            max = dp[i]
        }
    }
    return n - max
}