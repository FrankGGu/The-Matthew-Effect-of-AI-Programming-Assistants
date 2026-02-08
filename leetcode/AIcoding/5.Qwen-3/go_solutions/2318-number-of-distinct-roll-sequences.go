package main

func distinctSequences(n int) int {
    if n == 1 {
        return 6
    }
    dp := make([][7]int, n)
    for i := 1; i <= 6; i++ {
        dp[0][i] = 1
    }
    for i := 1; i < n; i++ {
        for a := 1; a <= 6; a++ {
            for b := 1; b <= 6; b++ {
                if b == a {
                    continue
                }
                for c := 1; c <= 6; c++ {
                    if c == b || c == a {
                        continue
                    }
                    dp[i][c] += dp[i-1][b]
                }
            }
        }
    }
    res := 0
    for i := 1; i <= 6; i++ {
        res += dp[n-1][i]
    }
    return res
}