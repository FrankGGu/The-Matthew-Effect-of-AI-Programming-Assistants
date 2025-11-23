func countTexts(pressedKeys string) int {
    const mod = 1e9 + 7
    n := len(pressedKeys)
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] % mod
        if i >= 2 && pressedKeys[i-1] == pressedKeys[i-2] {
            dp[i] = (dp[i] + dp[i-2]) % mod
            if i >= 3 && pressedKeys[i-1] == pressedKeys[i-3] {
                dp[i] = (dp[i] + dp[i-3]) % mod
                if (pressedKeys[i-1] == '7' || pressedKeys[i-1] == '9') && i >= 4 && pressedKeys[i-1] == pressedKeys[i-4] {
                    dp[i] = (dp[i] + dp[i-4]) % mod
                }
            }
        }
    }
    return dp[n]
}