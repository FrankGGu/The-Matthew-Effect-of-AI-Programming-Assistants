package main

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func longestPalindrome(words []string) int {
	counts := make(map[string]int)
	for _, word := range words {
		counts[word]++
	}

	ans := 0
	hasOddPalindrome := false

	for word, freq := range counts {
		if freq == 0 {
			continue
		}

		if word[0] == word[1] {
			ans += (freq / 2) * 4
			if freq%2 == 1 {
				hasOddPalindrome = true
			}
		} else {
			revWord := string(word[1]) + string(word[0])

			if revCount, ok := counts[revWord]; ok {
				numPairs := min(freq, revCount)
				ans += numPairs * 4

				counts[word] -= numPairs
				counts[revWord] -= numPairs
			}
		}
	}

	if hasOddPalindrome {
		ans += 2
	}

	return ans
}