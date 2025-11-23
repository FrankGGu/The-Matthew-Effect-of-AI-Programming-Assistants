func maximumProduct(nums []int, k int) int {
    mod := int(1e9 + 7)
    n := len(nums)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 2*k+1)
        for j := range dp[i] {
            dp[i][j] = -1 << 31
        }
    }
    dp[0][k] = 1

    for i := 1; i <= n; i++ {
        num := nums[i-1]
        for j := 0; j <= 2*k; j++ {
            if dp[i-1][j] == -1 << 31 {
                continue
            }
            if j + num <= 2*k {
                if dp[i][j+num] < dp[i-1][j] * num % mod {
                    dp[i][j+num] = dp[i-1][j] * num % mod
                }
            }
            if j - num >= 0 {
                if dp[i][j-num] < dp[i-1][j] * num % mod {
                    dp[i][j-num] = dp[i-1][j] * num % mod
                }
            }
        }
    }

    if dp[n][k] == -1 << 31 {
        return 0
    }
    return dp[n][k]
}