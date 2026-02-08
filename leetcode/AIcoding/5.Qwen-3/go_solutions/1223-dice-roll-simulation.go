package main

func dieSimulator(n int, k int) int {
    mod := 1000000007
    dp := make([]int, k+1)
    for i := 0; i < n; i++ {
        newDp := make([]int, k+1)
        for j := 0; j <= k; j++ {
            for l := 0; l < 6; l++ {
                if j+l <= k {
                    newDp[j+l] = (newDp[j+l] + dp[j]) % mod
                }
            }
        }
        dp = newDp
    }
    return dp[k]
}