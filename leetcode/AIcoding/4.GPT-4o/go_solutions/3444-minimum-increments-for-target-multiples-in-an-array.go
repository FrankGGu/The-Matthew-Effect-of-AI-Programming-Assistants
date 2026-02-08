func minIncrements(n int, cost []int, target int) int {
    dp := make([]int, target+1)
    for i := 1; i <= target; i++ {
        dp[i] = int(1e9)
    }
    dp[0] = 0

    for _, c := range cost {
        for j := target; j >= c; j-- {
            dp[j] = min(dp[j], dp[j-c]+c)
        }
    }
    result := dp[target]
    if result == int(1e9) {
        return -1
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}