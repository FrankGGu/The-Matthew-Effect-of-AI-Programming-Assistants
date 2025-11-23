func findGoodStrings(n int, s1 string, s2 string, evil string) int {
    mod := 1_000_000_007
    m := len(evil)
    dp := make([][][]int, n+1)
    for i := range dp {
        dp[i] = make([][]int, m+1)
        for j := range dp[i] {
            dp[i][j] = make([]int)(2)
        }
    }
    dp[0][0][0] = 1

    for i := 0; i <= n; i++ {
        for j := 0; j <= m; j++ {
            for k := 0; k < 2; k++ {
                if dp[i][j][k] == 0 {
                    continue
                }
                for c := 0; c < 26; c++ {
                    ch := byte('a' + c)
                    if i < n {
                        ni := i + 1
                        nj := j
                        if ch == s1[i] {
                            nj = j
                        } else if ch == s2[i] {
                            nj = j
                        } else {
                            nj = j
                        }
                        for nj > 0 && (nj >= m || ch != evil[nj]) {
                            nj = next[nj]
                        }
                        if nj < m {
                            dp[ni][nj][1] = (dp[ni][nj][1] + dp[i][j][k]) % mod
                        } else {
                            dp[ni][nj][0] = (dp[ni][nj][0] + dp[i][j][k]) % mod
                        }
                    }
                }
            }
        }
    }

    ans := 0
    for j := 0; j <= m; j++ {
        ans = (ans + dp[n][j][0] + dp[n][j][1]) % mod
    }
    return ans
}