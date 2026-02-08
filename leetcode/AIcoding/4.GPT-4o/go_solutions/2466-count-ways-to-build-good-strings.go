func countGoodStrings(low int, high int, zero int, one int) int {
    const mod = 1000000007
    dp := make([]int, high+1)
    dp[0] = 1

    for i := 0; i <= high; i++ {
        if i + zero <= high {
            dp[i+zero] = (dp[i+zero] + dp[i]) % mod
        }
        if i + one <= high {
            dp[i+one] = (dp[i+one] + dp[i]) % mod
        }
    }

    result := 0
    for i := low; i <= high; i++ {
        result = (result + dp[i]) % mod
    }

    return result
}