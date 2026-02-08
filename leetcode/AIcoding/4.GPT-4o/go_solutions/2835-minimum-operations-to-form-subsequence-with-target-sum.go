func minOperations(nums []int, target int) int {
    n := len(nums)
    dp := make([]int, target+1)
    for i := 1; i <= target; i++ {
        dp[i] = n + 1
    }
    dp[0] = 0

    for _, num := range nums {
        for j := target; j >= num; j-- {
            dp[j] = min(dp[j], dp[j-num]+1)
        }
    }

    if dp[target] == n+1 {
        return -1
    }
    return dp[target]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}