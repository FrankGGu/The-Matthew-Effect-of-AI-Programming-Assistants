func minCost(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = 1 << 60
    }
    dp[0] = 0

    for i := 1; i <= n; i++ {
        unique := make(map[int]int)
        cost := 0
        for j := i; j > 0; j-- {
            unique[nums[j-1]]++
            if unique[nums[j-1]] == 1 {
                cost++
            }
            dp[i] = min(dp[i], dp[j-1]+cost+k-1)
        }
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}