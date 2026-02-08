func waysToReachTarget(target int, types [][]int) int {
    dp := make([]int, target+1)
    dp[0] = 1
    for _, t := range types {
        count := t[0]
        mark := t[1]
        for i := 1; i <= count; i++ {
            for j := mark; j <= target; j++ {
                dp[j] = (dp[j] + dp[j-mark]) % 1000000007
            }
        }
    }
    return dp[target]
}