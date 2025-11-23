func getHint(secret string, guess string) string {
    bulls := 0
    cows := 0
    secretCount := make([]int, 10)
    guessCount := make([]int, 10)

    for i := 0; i < len(secret); i++ {
        s := secret[i] - '0'
        g := guess[i] - '0'
        if s == g {
            bulls++
        } else {
            secretCount[s]++
            guessCount[g]++
        }
    }

    for i := 0; i < 10; i++ {
        cows += min(secretCount[i], guessCount[i])
    }

    return fmt.Sprintf("%dA%dB", bulls, cows)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}