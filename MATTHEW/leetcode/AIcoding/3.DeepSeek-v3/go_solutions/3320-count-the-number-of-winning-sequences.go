func countWinningSequences(n int, m int, k int) int {
    const mod = 1e9 + 7

    if n == 1 {
        return m % mod
    }

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+2)
    }

    for j := 1; j <= m; j++ {
        dp[1][j] = 1
    }

    prefix := make([]int, m+2)
    for j := 1; j <= m; j++ {
        prefix[j] = (prefix[j-1] + dp[1][j]) % mod
    }

    for i := 2; i <= n; i++ {
        for j := 1; j <= m; j++ {
            left := 1
            if j - k >= 1 {
                left = j - k + 1
            }
            right := m
            if j + k <= m {
                right = j + k - 1
            }

            sum := (prefix[left-1] + (prefix[m] - prefix[right] + mod) % mod) % mod
            dp[i][j] = sum
        }

        for j := 1; j <= m; j++ {
            prefix[j] = (prefix[j-1] + dp[i][j]) % mod
        }
    }

    res := 0
    for j := 1; j <= m; j++ {
        res = (res + dp[n][j]) % mod
    }

    return res
}