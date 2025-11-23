package main

func longestBeautifulSubstring(word string) int {
	maxLen := 0
	currentLen := 0
	lastVowelIdx := -1 // Index in "aeiou" string for the last vowel encountered (0 for 'a', 1 for 'e', etc.)
	vowelMask := 0     // Bitmask to track unique vowels (1 for 'a', 2 for 'e', 4 for 'i', 8 for 'o', 16 for 'u')

	// Using an array for faster lookup than a map
	// 'a':0, 'e':1, 'i':2, 'o':3, 'u':4
	// All other chars will have -1
	vowelOrder := [26]int{}
	for i := range vowelOrder {
		vowelOrder[i] = -1
	}
	vowelOrder['a'-'a'] = 0
	vowelOrder['e'-'a'] = 1
	vowelOrder['i'-'a'] = 2
	vowelOrder['o'-'a'] = 3
	vowelOrder['u'-'a'] = 4

	for i := 0; i < len(word); i++ {
		char := word[i]
		charIdx := vowelOrder[char-'a']

		if charIdx != -1 { // It's a vowel
			if charIdx == lastVowelIdx { // Same vowel, extend current sequence
				currentLen++
			} else if charIdx == lastVowelIdx+1 { // Next vowel in order, extend sequence and update lastVowelIdx
				currentLen++
				lastVowelIdx = charIdx
				vowelMask |= (1 << charIdx) // Set the bit for this vowel
			} else if charIdx == 0 { // Current char is 'a', start a new sequence
				currentLen = 1
				lastVowelIdx = 0
				vowelMask = (1 << 0) // Only 'a' is seen
			} else { // Invalid transition (e.g., 'i' after 'a', or 'e' when no vowel seen yet, or 'a' after 'e' but not starting a new 'a' sequence)
				// Reset
				currentLen = 0
				lastVowelIdx = -1
				vowelMask = 0
			}
		} else { // It's a consonant
			// Reset
			currentLen = 0
			lastVowelIdx = -1
			vowelMask = 0
		}

		// Check if all 5 vowels have been seen in order in the current sequence
		if vowelMask == 0b11111 { // 0b11111 is 31 (all bits for 'a' through 'u' set)
			if currentLen > maxLen {
				maxLen = currentLen
			}
		}
	}

	return maxLen
}