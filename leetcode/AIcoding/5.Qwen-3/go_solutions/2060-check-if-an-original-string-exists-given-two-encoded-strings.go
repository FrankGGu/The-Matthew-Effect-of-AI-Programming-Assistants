package main

func possiblyEquals(s string, t string) bool {
    n := len(s)
    m := len(t)

    dp := make([][]bool, n+1)
    for i := range dp {
        dp[i] = make([]bool, m+1)
    }

    dp[0][0] = true

    for i := 0; i <= n; i++ {
        for j := 0; j <= m; j++ {
            if !dp[i][j] {
                continue
            }
            if i < n && j < m {
                if s[i] == t[j] {
                    dp[i+1][j+1] = true
                }
            }
            k := i
            for k < n && isDigit(s[k]) {
                k++
            }
            for k > i {
                num := 0
                for l := i; l < k; l++ {
                    num = num*10 + int(s[l]-'0')
                }
                if j+num <= m {
                    dp[k][j+num] = true
                }
                i++
            }
            k = j
            for k < m && isDigit(t[k]) {
                k++
            }
            for k > j {
                num := 0
                for l := j; l < k; l++ {
                    num = num*10 + int(t[l]-'0')
                }
                if i+num <= n {
                    dp[i+num][k] = true
                }
                j++
            }
        }
    }

    return dp[n][m]
}

func isDigit(b byte) bool {
    return b >= '0' && b <= '9'
}