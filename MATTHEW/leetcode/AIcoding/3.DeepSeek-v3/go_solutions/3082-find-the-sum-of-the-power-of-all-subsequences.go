func sumOfPower(nums []int, k int) int {
    const mod = 1e9 + 7
    n := len(nums)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    dp[0][0] = 1

    for _, num := range nums {
        for i := n; i >= 1; i-- {
            for j := k; j >= num; j-- {
                dp[i][j] = (dp[i][j] + dp[i-1][j-num]) % mod
            }
        }
    }

    res := 0
    pow := 1
    for i := 1; i <= n; i++ {
        res = (res + dp[i][k] * pow) % mod
        pow = pow * 2 % mod
    }
    return res
}