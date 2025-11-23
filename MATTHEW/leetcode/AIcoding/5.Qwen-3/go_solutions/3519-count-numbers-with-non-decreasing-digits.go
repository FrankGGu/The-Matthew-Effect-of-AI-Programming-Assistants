package main

func countNumbersWithNonDecreasingDigits(n int) int {
    s := strconv.Itoa(n)
    m := len(s)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, 10)
    }
    for i := 0; i < 10; i++ {
        dp[0][i] = 1
    }
    for i := 1; i < m; i++ {
        for d := 0; d < 10; d++ {
            for prev := 0; prev <= d; prev++ {
                dp[i][d] += dp[i-1][prev]
            }
        }
    }
    res := 0
    for d := 0; d < int(s[0]-'0'); d++ {
        res += dp[m-1][d]
    }
    for i := 1; i < m; i++ {
        for d := 0; d < int(s[i]-'0'); d++ {
            if d >= int(s[i-1]-'0') {
                res += dp[m-i-1][d]
            }
        }
    }
    return res + 1
}