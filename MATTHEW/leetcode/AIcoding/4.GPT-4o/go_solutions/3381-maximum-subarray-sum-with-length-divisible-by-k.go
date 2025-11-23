func maxSumDivK(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, k)
    dp[0] = 0
    maxSum := 0

    for i := 0; i < n; i++ {
        tmp := make([]int, k)
        for j := 0; j < k; j++ {
            tmp[j] = dp[j]
        }
        for j := 0; j < k; j++ {
            tmp[(j+1)%k] = max(tmp[(j+1)%k], dp[j]+nums[i])
        }
        dp = tmp
        if i+1 >= k {
            maxSum = max(maxSum, dp[0])
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}