func smallestSubstringWithIdenticalCharactersII(s string) int {
	charPresent := [26]bool{}
	uniqueCharCount := 0

	for _, r := range s {
		if !charPresent[r-'a'] {
			charPresent[r-'a'] = true
			uniqueCharCount++
		}
	}

	if uniqueCharCount > 1 {
		return -1
	}

	// If uniqueCharCount is 0, it means the string s is empty.
	// However, problem constraints typically state s.length >= 1,
	// so uniqueCharCount will always be at least 1.
	// If uniqueCharCount is 1, it means s contains only one type of character.
	// In this case, a substring of length 1 (e.g., "a") consisting of that character
	// will satisfy the condition of being a "good" substring and containing all
	// unique characters from s (since s itself only has one unique character).
	// This is the smallest possible length.
	return 1
}