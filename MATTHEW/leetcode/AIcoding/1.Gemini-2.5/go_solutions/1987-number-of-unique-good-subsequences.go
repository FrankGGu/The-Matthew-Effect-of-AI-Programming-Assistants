func numberOfUniqueGoodSubsequences(s string) int {
	seen := make(map[string]bool)

	first := make(map[rune]int)
	last := make(map[rune]int)

	for i, r := range s {
		if _, ok := first[r]; !ok {
			first[r] = i
		}
		last[r] = i
	}

	for r := '0'; r <= '9'; r++ {
		firstIdx, ok1 := first[r]
		lastIdx, ok2 := last[r]

		if !ok1 {
			continue
		}

		// Case 1: Subsequence of length 1: "r"
		seen[string(r)] = true

		if firstIdx == lastIdx {
			continue
		}

		// Case 2: Subsequence of length 2: "rr"
		// Using s[firstIdx] and s[lastIdx]
		seen[string(r)+string(r)] = true

		// Case 3: Subsequences of length 3: "rXr"
		// X can be any character between firstIdx and lastIdx (exclusive)
		middleChars := make(map[rune]bool)
		for i := firstIdx + 1; i < lastIdx; i++ {
			middleChars[rune(s[i])] = true
		}

		for middleChar := range middleChars {
			seen[string(r)+string(middleChar)+string(r)] = true
		}
	}

	return len(seen)
}