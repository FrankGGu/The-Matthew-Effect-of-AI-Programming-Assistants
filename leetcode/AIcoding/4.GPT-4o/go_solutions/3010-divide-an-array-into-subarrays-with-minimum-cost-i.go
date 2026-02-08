func minCost(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = 1 << 30
    }
    dp[0] = 0

    for i := 1; i <= n; i++ {
        freq := make(map[int]int)
        unique := 0
        for j := i; j >= 1; j-- {
            if freq[nums[j-1]] == 0 {
                unique++
            }
            freq[nums[j-1]]++
            dp[i] = min(dp[i], dp[j-1]+unique+k-1)
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