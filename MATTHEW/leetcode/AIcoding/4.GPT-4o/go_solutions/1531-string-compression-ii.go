func getLengthOfOptimalCompression(s string, k int) int {
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = n + 1
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            dp[i][j] = min(dp[i][j], dp[i-1][j]+1)
            if j > 0 {
                dp[i][j] = min(dp[i][j], dp[i-1][j-1])
            }
            count := 0
            for l := i; l >= 1; l-- {
                if s[l-1] == s[i-1] {
                    count++
                    if count > 1 {
                        newLen := 1 + lenInt(count)
                        if j >= (i-l) {
                            dp[i][j] = min(dp[i][j], dp[l-1][j-(i-l)]+newLen)
                        }
                    } else {
                        if j >= (i-l) {
                            dp[i][j] = min(dp[i][j], dp[l-1][j-(i-l)]+1)
                        }
                    }
                } else {
                    if j >= (i-l) {
                        dp[i][j] = min(dp[i][j], dp[l-1][j-(i-l)]+1)
                    }
                    break
                }
            }
        }
    }

    minLength := n + 1
    for j := 0; j <= k; j++ {
        minLength = min(minLength, dp[n][j])
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func lenInt(x int) int {
    if x == 0 {
        return 1
    }
    length := 0
    for x > 0 {
        x /= 10
        length++
    }
    return length
}