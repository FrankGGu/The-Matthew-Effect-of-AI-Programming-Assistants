func numWays(words []string, target string) int {
	const MOD = 1_000_000_007

	targetLen := len(target)
	wordLen := len(words[0])

	counts := make([][]int, wordLen)
	for k := 0; k < wordLen; k++ {
		counts[k] = make([]int, 26)
	}

	for _, word := range words {
		for k, char := range word {
			counts[k][char-'a']++
		}
	}

	dpPrev := make([]int, wordLen+1)
	for j := 0; j <= wordLen; j++ {
		dpPrev[j] = 1
	}

	for i := 1; i <= targetLen; i++ {
		dpCurr := make([]int, wordLen+1)
		charToMatch := target[i-1]

		for j := 1; j <= wordLen; j++ {
			// Option 1: Don't use the (j-1)-th column from words
			// The number of ways to form target[0...i-1] using words up to column j-2
			dpCurr[j] = dpCurr[j-1]

			// Option 2: Use the (j-1)-th column from words to match target[i-1]
			// This requires forming target[0...i-2] using words up to column j-2
			// and target[i-1] matching a character at column j-1 in words.
			waysPrevPrefix := dpPrev[j-1]
			numOccurrences := counts[j-1][charToMatch-'a']

			waysWithMatch := (waysPrevPrefix * numOccurrences) % MOD

			dpCurr[j] = (dpCurr[j] + waysWithMatch) % MOD
		}
		dpPrev = dpCurr
	}

	return dpPrev[wordLen]
}