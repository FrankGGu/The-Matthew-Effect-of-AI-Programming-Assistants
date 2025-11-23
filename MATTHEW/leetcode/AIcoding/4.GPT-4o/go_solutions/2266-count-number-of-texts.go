func countTexts(pressedKeys string) int {
    mod := int(1e9 + 7)
    dp := make([]int, len(pressedKeys)+1)
    dp[0] = 1

    for i := 1; i <= len(pressedKeys); i++ {
        count := 1
        for j := i; j >= 1 && count <= 4; j-- {
            if pressedKeys[j-1] == pressedKeys[i-1] {
                dp[i] = (dp[i] + dp[j-1]) % mod
                count++
            } else {
                break
            }
        }
    }

    return dp[len(pressedKeys)]
}