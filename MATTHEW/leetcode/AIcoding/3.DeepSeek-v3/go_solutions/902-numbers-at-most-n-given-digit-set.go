func atMostNGivenDigitSet(digits []string, n int) int {
    s := strconv.Itoa(n)
    k := len(s)
    dp := make([]int, k+1)
    dp[k] = 1

    for i := k - 1; i >= 0; i-- {
        for _, d := range digits {
            if d[0] < s[i] {
                dp[i] += pow(len(digits), k - i - 1)
            } else if d[0] == s[i] {
                dp[i] += dp[i+1]
            }
        }
    }

    for i := 1; i < k; i++ {
        dp[0] += pow(len(digits), i)
    }
    return dp[0]
}

func pow(a, b int) int {
    res := 1
    for i := 0; i < b; i++ {
        res *= a
    }
    return res
}