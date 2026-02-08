func getHint(secret string, guess string) string {
    bullCount, cowCount := 0, 0
    countSecret := make([]int, 10)
    countGuess := make([]int, 10)

    for i := 0; i < len(secret); i++ {
        if secret[i] == guess[i] {
            bullCount++
        } else {
            countSecret[secret[i]-'0']++
            countGuess[guess[i]-'0']++
        }
    }

    for i := 0; i < 10; i++ {
        cowCount += min(countSecret[i], countGuess[i])
    }

    return fmt.Sprintf("%dA%dB", bullCount, cowCount)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}