func countSpecialSubsequences(nums []int) int {
    const mod = 1_000_000_007
    n := len(nums)
    dp := make([][4]int, n+1)
    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        dp[i][0] = dp[i-1][0]
        dp[i][1] = dp[i-1][1]
        dp[i][2] = dp[i-1][2]
        dp[i][3] = dp[i-1][3]

        if nums[i-1] == 0 {
            dp[i][0] = (dp[i][0] * 2) % mod
        } else if nums[i-1] == 1 {
            dp[i][1] = (dp[i][1] + dp[i-1][0]) % mod
            dp[i][0] = (dp[i][0] * 2) % mod
        } else if nums[i-1] == 2 {
            dp[i][2] = (dp[i][2] + dp[i-1][1]) % mod
            dp[i][1] = (dp[i][1] * 2) % mod
            dp[i][0] = (dp[i][0] * 2) % mod
        } else if nums[i-1] == 3 {
            dp[i][3] = (dp[i][3] + dp[i-1][2]) % mod
            dp[i][2] = (dp[i][2] * 2) % mod
            dp[i][1] = (dp[i][1] * 2) % mod
            dp[i][0] = (dp[i][0] * 2) % mod
        }
    }

    return (dp[n][3] + mod - 1) % mod
}