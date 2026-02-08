func numWays(keys [][]int, target string) int {
    mod := 1_000_000_007
    m, n := len(keys), len(target)

    dp := make([]int, n+1)
    dp[0] = 1

    for i := 0; i < m; i++ {
        count := make([]int, 26)
        for _, key := range keys[i] {
            count[key]++
        }
        for j := n; j > 0; j-- {
            dp[j] = (dp[j] + int64(dp[j-1])*int64(count[target[j-1]-'a'])) % int64(mod)
        }
    }

    return dp[n]
}