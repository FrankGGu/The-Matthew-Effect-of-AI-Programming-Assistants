func sumOfPower(nums []int, k int) int {
    const mod = 1e9 + 7
    n := len(nums)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        num := nums[i-1]
        for j := 0; j <= k; j++ {
            dp[i][j] = dp[i-1][j]
            if j >= num {
                dp[i][j] = (dp[i][j] + dp[i-1][j-num]) % mod
            }
        }
    }

    res := 0
    for l := 1; l <= n; l++ {
        res = (res + dp[l][k]) % mod
    }
    return res
}