func keyboard(k int, n int) int {
    const mod = 1e9 + 7
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 27)
    }
    dp[0][0] = 1
    for i := 1; i <= n; i++ {
        for j := 1; j <= 26; j++ {
            for l := 0; l <= k; l++ {
                if i-l >= 0 {
                    dp[i][j] = (dp[i][j] + dp[i-l][j-1] * comb(l)) % mod
                }
            }
        }
    }
    res := 0
    for j := 1; j <= 26; j++ {
        res = (res + dp[n][j]) % mod
    }
    return res
}

var memo = make(map[int]int)

func comb(m int) int {
    if val, ok := memo[m]; ok {
        return val
    }
    res := 1
    for i := 1; i <= m; i++ {
        res = res * i
    }
    memo[m] = res
    return res
}