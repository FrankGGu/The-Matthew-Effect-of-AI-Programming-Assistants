func countVowelPermutation(n int) int {
    mod := 1000000007
    dp := [5]int{1, 1, 1, 1, 1}
    for i := 1; i < n; i++ {
        newDp := [5]int{}
        newDp[0] = (dp[1] + dp[2] + dp[4]) % mod
        newDp[1] = (dp[0] + dp[2]) % mod
        newDp[2] = (dp[1] + dp[3]) % mod
        newDp[3] = dp[2] % mod
        newDp[4] = (dp[2] + dp[3]) % mod
        dp = newDp
    }
    return (dp[0] + dp[1] + dp[2] + dp[3] + dp[4]) % mod
}