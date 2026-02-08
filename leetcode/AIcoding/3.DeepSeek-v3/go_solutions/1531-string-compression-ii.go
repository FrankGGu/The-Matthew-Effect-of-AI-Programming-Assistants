func getLengthOfOptimalCompression(s string, k int) int {
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = n
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            if j > 0 {
                dp[i][j] = dp[i-1][j-1]
            }
            cnt, del := 0, 0
            for l := i; l >= 1; l-- {
                if s[l-1] == s[i-1] {
                    cnt++
                } else {
                    del++
                }
                if del > j {
                    break
                }
                var length int
                if cnt >= 100 {
                    length = 4
                } else if cnt >= 10 {
                    length = 3
                } else if cnt >= 2 {
                    length = 2
                } else {
                    length = 1
                }
                if dp[l-1][j-del] + length < dp[i][j] {
                    dp[i][j] = dp[l-1][j-del] + length
                }
            }
        }
    }
    return dp[n][k]
}