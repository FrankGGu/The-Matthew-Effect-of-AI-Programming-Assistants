package main

func wonderfulSubstrings(word string) int64 {
	var count int64
	freq := make([]int, 1024) // Stores frequency of each prefix mask

	// An empty prefix has a mask of 0 (all characters appear 0 times, which is even).
	// Initialize freq[0] to 1 to account for substrings starting from the beginning of the word.
	freq[0] = 1

	currentMask := 0

	for _, char := range word {
		// Update the current mask based on the character.
		// 'a' corresponds to bit 0, 'b' to bit 1, ..., 'j' to bit 9.
		currentMask ^= (1 << (char - 'a'))

		// Case 1: The current substring (ending at 'char') has all characters appearing an even number of times.
		// This means currentMask ^ prevMask == 0, implying currentMask == prevMask.
		// Add the count of previous prefixes that had the same mask.
		count += int64(freq[currentMask])

		// Case 2: The current substring has exactly one character appearing an odd number of times.
		// This means currentMask ^ prevMask == (1 << k) for some k (0 to 9).
		// Implies prevMask == currentMask ^ (1 << k).
		// Iterate through all possible 'k' (0 to 9) to check for such previous masks.
		for k := 0; k < 10; k++ {
			targetMask := currentMask ^ (1 << k)
			count += int64(freq[targetMask])
		}

		// Increment the frequency of the current mask for future calculations.
		freq[currentMask]++
	}

	return count
}