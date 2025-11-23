func maxScore(nums []int, x int) int64 {
    n := len(nums)
    dp := make([]int64, 2)
    if nums[0]%2 == 0 {
        dp[0] = int64(nums[0])
        dp[1] = int64(nums[0]) - int64(x)
    } else {
        dp[1] = int64(nums[0])
        dp[0] = int64(nums[0]) - int64(x)
    }

    for i := 1; i < n; i++ {
        parity := nums[i] % 2
        current := int64(nums[i])
        if dp[parity] + current > dp[1-parity] + current - int64(x) {
            dp[parity] = dp[parity] + current
        } else {
            dp[parity] = dp[1-parity] + current - int64(x)
        }
    }

    if dp[0] > dp[1] {
        return dp[0]
    }
    return dp[1]
}