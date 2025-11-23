package main

func longestPalindrome(words []string) int {
	counts := make(map[string]int)
	for _, word := range words {
		counts[word]++
	}

	ans := 0
	hasOddPalindrome := false

	for word, count := range counts {
		if count == 0 {
			continue
		}

		// Reverse a 2-letter word
		revWord := string(word[1]) + string(word[0])

		if word == revWord { // Palindrome word itself, e.g., "gg"
			ans += (count / 2) * 4
			if count%2 == 1 {
				hasOddPalindrome = true
			}
			counts[word] = 0 // Mark as used
		} else { // Non-palindrome word, e.g., "ab"
			// Only process if word < revWord to avoid double counting pairs
			// and ensure we process when the "smaller" word is encountered.
			// If word > revWord, it means we would have already processed this pair
			// when we iterated over revWord (e.g., "ba" would be processed when "ab" was the current word).
			if word < revWord { 
				if counts[revWord] > 0 {
					minCount := min(count, counts[revWord])
					ans += minCount * 4
					counts[word] -= minCount
					counts[revWord] -= minCount
				}
			}
		}
	}

	if hasOddPalindrome {
		ans += 2
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}