package main

func findSubstringInWraproundString(p string) int {
	if len(p) == 0 {
		return 0
	}

	maxLen := [26]int{}
	currentLen := 0

	for i := 0; i < len(p); i++ {
		charIndex := p[i] - 'a'
		if i == 0 {
			currentLen = 1
		} else {
			prevCharIndex := p[i-1] - 'a'
			// Check if the current character is consecutive to the previous one
			// This includes the wrap-around case from 'z' to 'a'
			if charIndex == (prevCharIndex+1)%26 {
				currentLen++
			} else {
				currentLen = 1
			}
		}

		// Update the maximum length of a valid wraparound substring ending with the current character
		if currentLen > maxLen[charIndex] {
			maxLen[charIndex] = currentLen
		}
	}

	totalUniqueSubstrings := 0
	for i := 0; i < 26; i++ {
		totalUniqueSubstrings += maxLen[i]
	}

	return totalUniqueSubstrings
}