func kthSmallest(coins []int, k int) int {
    n := len(coins)
    dp := make([]int, k+1)
    dp[0] = 1

    for _, coin := range coins {
        for j := k; j >= coin; j-- {
            dp[j] += dp[j-coin]
        }
    }

    count := 0
    for i := 1; i <= k; i++ {
        count += dp[i]
        if count >= k {
            return i
        }
    }

    return -1
}