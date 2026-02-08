package main

func minimumJump(steps []int) int {
    n := len(steps)
    dp := make([]int, n)
    for i := 1; i < n; i++ {
        dp[i] = -1
    }
    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if dp[j] != -1 && steps[j] >= i-j {
                if dp[i] == -1 || dp[j]+1 < dp[i] {
                    dp[i] = dp[j] + 1
                }
            }
        }
    }
    return dp[n-1]
}