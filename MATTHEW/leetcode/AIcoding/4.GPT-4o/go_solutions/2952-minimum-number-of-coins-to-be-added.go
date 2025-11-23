func minCoins(coins []int) int {
    sum := 0
    for _, coin := range coins {
        sum += coin
    }

    if sum == 0 {
        return 0
    }

    dp := make([]int, sum+1)
    for i := range dp {
        dp[i] = sum + 1
    }
    dp[0] = 0

    for _, coin := range coins {
        for j := coin; j <= sum; j++ {
            dp[j] = min(dp[j], dp[j-coin]+1)
        }
    }

    result := dp[sum]
    if result == sum + 1 {
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