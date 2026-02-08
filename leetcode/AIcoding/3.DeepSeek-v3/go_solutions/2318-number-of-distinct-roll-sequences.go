func distinctSequences(n int) int {
    if n == 1 {
        return 6
    }

    mod := int(1e9) + 7
    dp := make([][7][7]int, n+1)

    for i := 1; i <= 6; i++ {
        for j := 1; j <= 6; j++ {
            if i != j && gcd(i, j) == 1 {
                dp[2][i][j] = 1
            }
        }
    }

    for k := 3; k <= n; k++ {
        for i := 1; i <= 6; i++ {
            for j := 1; j <= 6; j++ {
                if i == j || gcd(i, j) != 1 {
                    continue
                }
                for l := 1; l <= 6; l++ {
                    if l == j {
                        continue
                    }
                    if gcd(l, j) == 1 {
                        dp[k][j][i] = (dp[k][j][i] + dp[k-1][l][j]) % mod
                    }
                }
            }
        }
    }

    res := 0
    for i := 1; i <= 6; i++ {
        for j := 1; j <= 6; j++ {
            res = (res + dp[n][i][j]) % mod
        }
    }
    return res
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}