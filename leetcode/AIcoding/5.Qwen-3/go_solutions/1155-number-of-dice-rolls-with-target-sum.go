package main

func numRollsToTarget(n int, k int, target int) int {
    MOD := 1000000007
    dp := make([]int, target+1)
    dp[0] = 1
    for i := 0; i < n; i++ {
        nextDp := make([]int, target+1)
        for j := 0; j <= target; j++ {
            if dp[j] == 0 {
                continue
            }
            for face := 1; face <= k; face++ {
                if j+face <= target {
                    nextDp[j+face] = (nextDp[j+face] + dp[j]) % MOD
                }
            }
        }
        dp = nextDp
    }
    return dp[target]
}