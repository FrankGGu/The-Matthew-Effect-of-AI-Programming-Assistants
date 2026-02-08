func countMatches(s1, s2 string) int {
	matches := 0
	for i := 0; i < len(s1); i++ {
		if s1[i] == s2[i] {
			matches++
		}
	}
	return matches
}

func findSecretWord(wordlist []string, master *Master) {
	possibleWords := make([]string, len(wordlist))
	copy(possibleWords, wordlist)

	for guesses := 0; guesses < 10 && len(possibleWords) > 0; guesses++ {
		bestGuess := ""
		minMaxGroupSize := len(possibleWords) + 1

		for _, candidateGuess := range possibleWords {
			groups := make(map[int]int)
			for _, otherWord := range possibleWords {
				matches := countMatches(candidateGuess, otherWord)
				groups[matches]++
			}

			maxGroupSize := 0
			for _, size := range groups {
				if size > maxGroupSize {
					maxGroupSize = size
				}
			}

			if maxGroupSize < minMaxGroupSize {
				minMaxGroupSize = maxGroupSize
				bestGuess = candidateGuess
			}
		}

		result := master.Guess(bestGuess)

		if result == 6 {
			return
		}

		nextPossibleWords := []string{}
		for _, word := range possibleWords {
			if countMatches(bestGuess, word) == result {
				nextPossibleWords = append(nextPossibleWords, word)
			}
		}
		possibleWords = nextPossibleWords
	}
}