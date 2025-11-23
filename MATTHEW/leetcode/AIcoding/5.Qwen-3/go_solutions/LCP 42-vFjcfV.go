package main

func findRotateSteps(s string, target string) int {
    n := len(s)
    m := len(target)
    dp := make([]int, m)
    for i := 0; i < m; i++ {
        dp[i] = -1
    }
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if s[i] == target[j] {
                if j == 0 {
                    dp[j] = min(dp[j], i+1)
                } else {
                    if dp[j-1] != -1 {
                        steps := i - dp[j-1]
                        if steps < 0 {
                            steps += n
                        }
                        dp[j] = min(dp[j], dp[j-1]+steps+1)
                    }
                }
            }
        }
    }
    return dp[m-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}