func minCost(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + k
        count := make(map[int]int)
        cost := 0
        for j := i; j >= 1; j-- {
            count[nums[j-1]]++
            if count[nums[j-1]] == 2 {
                cost += 2
            } else if count[nums[j-1]] > 2 {
                cost += 1
            }
            dp[i] = min(dp[i], dp[j-1]+k+cost)
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