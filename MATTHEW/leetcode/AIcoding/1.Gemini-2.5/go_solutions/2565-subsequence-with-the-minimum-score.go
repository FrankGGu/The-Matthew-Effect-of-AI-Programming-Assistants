import "math"

func minimumScore(s string, t string) int {
	n := len(s)
	m := len(t)

	ans := math.MaxInt32

	// Iterate over all possible starting positions for t[0] in s
	for i := 0; i < n; i++ {
		if s[i] != t[0] {
			continue
		}

		currentSIndex := i
		currentTIndex := 0
		lastSIndexMatched := -1

		// Greedily find the earliest possible match for the rest of t
		for currentTIndex < m {
			if currentSIndex >= n {
				// Cannot match all of t from this starting point
				break
			}
			if s[currentSIndex] == t[currentTIndex] {
				lastSIndexMatched = currentSIndex
				currentTIndex++
			}
			currentSIndex++
		}

		// If all characters of t were matched
		if currentTIndex == m {
			score := lastSIndexMatched - i + 1
			if score < ans {
				ans = score
			}
		}
	}

	return ans
}