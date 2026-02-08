package main

func equalFrequency(word string) bool {
	// Step 1: Calculate initial frequencies of all characters in the word.
	charCounts := make(map[rune]int)
	for _, r := range word {
		charCounts[r]++
	}

	// Step 2: Iterate through each possible character ('a' through 'z').
	// For each character, try removing one instance of it and check if frequencies equalize.
	for i := 0; i < 26; i++ {
		charToRemove := rune('a' + i)

		// If the current character is not present in the word, skip it.
		if charCounts[charToRemove] == 0 {
			continue
		}

		// Temporarily decrement the count of the current character.
		charCounts[charToRemove]--

		// Step 3: Check if all remaining non-zero frequencies are equal.
		distinctFrequencies := make(map[int]struct{}) // Use a map to store unique frequency values.
		for _, count := range charCounts {
			if count > 0 { // Only consider characters that are still present in the word.
				distinctFrequencies[count] = struct{}{}
			}
		}

		// After removing one character, there are two valid conditions for equal frequencies:
		// 1. All remaining characters have the same frequency (e.g., {1,1,1} -> distinctFrequencies will have one entry: {1}).
		// 2. There are no characters left in the word (e.g., word="a", remove 'a' -> distinctFrequencies will be empty).
		// Both these cases are covered by checking if the number of distinct frequency values is 0 or 1.
		if len(distinctFrequencies) <= 1 {
			return true
		}

		// Restore the count of the character for the next iteration.
		charCounts[charToRemove]++
	}

	// If no removal leads to equal frequencies, return false.
	return false
}