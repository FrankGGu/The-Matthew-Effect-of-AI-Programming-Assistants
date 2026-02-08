import "math"

func connectTwoGroups(cost [][]int) int {
    m, n := len(cost), len(cost[0])
    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for i := 0; i < m; i++ {
        nextDp := make([]int, 1<<n)
        copy(nextDp, dp)
        for j := 0; j < (1 << n); j++ {
            for k := 0; k < n; k++ {
                nextDp[j|(1<<k)] = min(nextDp[j|(1<<k)], dp[j]+cost[i][k])
            }
        }
        dp = nextDp
    }

    return dp[(1<<n)-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}