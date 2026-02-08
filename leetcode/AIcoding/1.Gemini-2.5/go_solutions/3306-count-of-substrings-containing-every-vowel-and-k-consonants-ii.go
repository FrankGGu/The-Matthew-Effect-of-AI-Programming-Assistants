package main

func countOfSubstrings(s string, k int) int64 {
	n := len(s)
	if n < 5+k { // Minimum length: 5 vowels + k consonants
		return 0
	}

	isVowel := func(c byte) bool {
		return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
	}

	vowelToIndex := map[byte]int{
		'a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4,
	}

	vowelFreq := [5]int{} // Frequencies of 'a', 'e', 'i', 'o', 'u'
	consonantCount := 0
	uniqueVowels := 0
	ans := int64(0)
	left := 0

	for right := 0; right < n; right++ {
		charR := s[right]
		if isVowel(charR) {
			idx := vowelToIndex[charR]
			vowelFreq[idx]++
			if vowelFreq[idx] == 1 {
				uniqueVowels++
			}
		} else {
			consonantCount++
		}

		// Shrink window from left if consonantCount exceeds k
		for consonantCount > k {
			charL := s[left]
			if isVowel(charL) {
				idx := vowelToIndex[charL]
				vowelFreq[idx]--
				if vowelFreq[idx] == 0 {
					uniqueVowels--
				}
			} else {
				consonantCount--
			}
			left++
		}

		// If current window [left, right] satisfies conditions
		// (exactly k consonants and all 5 unique vowels)
		if consonantCount == k && uniqueVowels == 5 {
			// Count how many valid starting points exist for substrings ending at 'right'.
			// A starting point 'p' (left <= p <= right) is valid if s[p...right]
			// has k consonants and all 5 unique vowels.
			// Since s[left...right] has k consonants, any s[p...right] with p > left
			// will have fewer than k consonants if s[p-1] was a consonant.
			// So, 'p' can only move forward if s[p-1] is a vowel.
			// Also, all 5 unique vowels must be maintained.

			// We count how many leading vowels can be removed from s[left...right]
			// without losing a unique vowel.

			count := 0
			tempLeft := left
			for {
				charTempLeft := s[tempLeft]
				if isVowel(charTempLeft) {
					idx := vowelToIndex[charTempLeft]
					if vowelFreq[idx] > 1 { // If this vowel is redundant, we can remove it
						count++
						tempLeft++
					} else { // This vowel is unique, cannot remove it without losing uniqueness
						break
					}
				} else { // This is a consonant, cannot remove it without changing consonantCount
					break
				}
			}
			ans += int64(count + 1) // +1 for the window starting at 'left' itself
		}
	}

	return ans
}