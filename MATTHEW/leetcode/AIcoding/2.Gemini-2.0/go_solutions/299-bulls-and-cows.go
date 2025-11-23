func getHint(secret string, guess string) string {
	bulls := 0
	cows := 0
	secretCounts := make(map[rune]int)
	guessCounts := make(map[rune]int)

	for i := 0; i < len(secret); i++ {
		if secret[i] == guess[i] {
			bulls++
		} else {
			secretCounts[rune(secret[i])]++
			guessCounts[rune(guess[i])]++
		}
	}

	for digit, count := range guessCounts {
		if secretCounts[digit] > 0 {
			cows += min(count, secretCounts[digit])
		}
	}

	return fmt.Sprintf("%dA%dB", bulls, cows)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}