func beautifulPartitions(s string, k int, minLength int) int {
    const mod = 1e9 + 7
    n := len(s)
    if n < k * minLength {
        return 0
    }

    isPrime := func(c byte) bool {
        return c == '2' || c == '3' || c == '5' || c == '7'
    }

    if !isPrime(s[0]) || isPrime(s[n-1]) {
        return 0
    }

    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1

    for i := 1; i <= k; i++ {
        sum := 0
        for j := i * minLength; j <= n; j++ {
            sum = (sum + dp[i-1][j-minLength]) % mod
            if isPrime(s[j-1]) {
                continue
            }
            if j >= minLength && isPrime(s[j-minLength]) {
                dp[i][j] = sum
            }
        }
    }

    return dp[k][n]
}