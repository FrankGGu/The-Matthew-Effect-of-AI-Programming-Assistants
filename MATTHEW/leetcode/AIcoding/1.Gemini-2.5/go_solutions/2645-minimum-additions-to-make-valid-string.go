func minimumAdditions(word string) int {
	k := 1          // Number of "abc" sequences
	expectedIdx := 0 // 0 for 'a', 1 for 'b', 2 for 'c'

	for _, char := range word {
		charVal := int(char - 'a')

		if charVal == expectedIdx {
			expectedIdx = (expectedIdx + 1) % 3
		} else if charVal == (expectedIdx+1)%3 {
			// char is one step ahead, e.g., expected 'a', got 'b'
			// This means we complete the current "abc" sequence and start a new one.
			k++
			expectedIdx = (expectedIdx + 2) % 3 // We matched 'b', so next we expect 'c'
		} else { // charVal == (expectedIdx + 2) % 3
			// char is two steps ahead, e.g., expected 'a', got 'c'
			// This means we complete the current "abc", then another "abc", and start a new one.
			k += 2
			expectedIdx = 0 // We matched 'c', so next we expect 'a'
		}
	}

	return 3*k - len(word)
}