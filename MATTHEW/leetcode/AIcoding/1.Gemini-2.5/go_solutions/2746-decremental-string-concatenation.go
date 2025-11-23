import "math"

func minimizeConcatenatedLength(words []string) int {
	n := len(words)

	// dp[firstCharIdx][lastCharIdx] stores the minimum total length
	// of the string formed by concatenating a prefix of words,
	// such that the resulting string starts with 'a'+firstCharIdx
	// and ends with 'a'+lastCharIdx.
	// We use two 2D slices for space optimization: dpPrev for the previous word's states,
	// and dpCurr for the current word's states.

	const infinity = math.MaxInt32 / 2 // Use /2 to prevent overflow when adding lengths

	// Initialize dpPrev with infinity
	dpPrev := make([][]int, 26)
	for i := range dpPrev {
		dpPrev[i] = make([]int, 26)
		for j := range dpPrev[i] {
			dpPrev[i][j] = infinity
		}
	}

	// Base case: for the first word (words[0])
	firstWord := words[0]
	firstWordLen := len(firstWord)
	firstCharIdx := int(firstWord[0] - 'a')
	lastCharIdx := int(firstWord[firstWordLen-1] - 'a')
	dpPrev[firstCharIdx][lastCharIdx] = firstWordLen

	// Iterate through the rest of the words
	for i := 1; i < n; i++ {
		currentWord := words[i]
		currentWordLen := len(currentWord)
		currentWordFirstCharIdx := int(currentWord[0] - 'a')
		currentWordLastCharIdx := int(currentWord[currentWordLen-1] - 'a')

		// Initialize dpCurr for the current word
		dpCurr := make([][]int, 26)
		for j := range dpCurr {
			dpCurr[j] = make([]int, 26)
			for k := range dpCurr[j] {
				dpCurr[j][k] = infinity
			}
		}

		// Iterate over all possible (prevFirstCharIdx, prevLastCharIdx) states from dpPrev
		for prevFirstCharIdx := 0; prevFirstCharIdx < 26; prevFirstCharIdx++ {
			for prevLastCharIdx := 0; prevLastCharIdx < 26; prevLastCharIdx++ {
				if dpPrev[prevFirstCharIdx][prevLastCharIdx] == infinity {
					continue // This previous state is not reachable
				}

				// Calculate the cost to append the current word
				costToAdd := currentWordLen
				if currentWordFirstCharIdx == prevLastCharIdx {
					costToAdd-- // Decrement cost if first char matches previous last char
				}

				// Update dpCurr: the new string starts with prevFirstCharIdx
				// and ends with currentWordLastCharIdx
				newLength := dpPrev[prevFirstCharIdx][prevLastCharIdx] + costToAdd
				dpCurr[prevFirstCharIdx][currentWordLastCharIdx] = min(dpCurr[prevFirstCharIdx][currentWordLastCharIdx], newLength)
			}
		}
		// Move to the next iteration by setting dpPrev to dpCurr
		dpPrev = dpCurr
	}

	// The final answer is the minimum length among all possible (firstChar, lastChar) states
	// after processing all words.
	minTotalLength := infinity
	for i := 0; i < 26; i++ {
		for j := 0; j < 26; j++ {
			minTotalLength = min(minTotalLength, dpPrev[i][j])
		}
	}

	return minTotalLength
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}