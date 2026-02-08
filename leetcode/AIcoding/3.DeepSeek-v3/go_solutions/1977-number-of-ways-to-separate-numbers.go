func numberOfCombinations(num string) int {
    const mod = 1e9 + 7
    n := len(num)
    if n == 0 || num[0] == '0' {
        return 0
    }

    // lcp[i][j] is the length of the longest common prefix between num[i:] and num[j:]
    lcp := make([][]int, n+1)
    for i := range lcp {
        lcp[i] = make([]int, n+1)
    }
    for i := n - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if num[i] == num[j] {
                lcp[i][j] = lcp[i+1][j+1] + 1
            }
        }
    }

    // dp[i][j] is the number of ways to split num[0..i] with the last number of length j
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        for j := 1; j <= i; j++ {
            if num[i-j] == '0' {
                dp[i][j] = 0
                continue
            }
            val := dp[i-j][j]
            if i >= 2*j {
                k := j
                if lcp[i-2*j][i-j] < j && num[i-2*j+lcp[i-2*j][i-j]] > num[i-j+lcp[i-2*j][i-j]] {
                    k = j + 1
                }
                if k <= i-j {
                    val = (val + dp[i-j][k]) % mod
                }
            }
            dp[i][j] = (dp[i][j-1] + val) % mod
        }
    }

    return dp[n][n]
}