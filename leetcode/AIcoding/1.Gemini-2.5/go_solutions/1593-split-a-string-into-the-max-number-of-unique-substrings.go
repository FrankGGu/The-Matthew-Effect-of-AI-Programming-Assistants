package main

func maxUniqueSplit(s string) int {
	maxCount := 0
	uniqueSubstrings := make(map[string]bool)

	var backtrack func(start int)
	backtrack = func(start int) {
		if start == len(s) {
			if len(uniqueSubstrings) > maxCount {
				maxCount = len(uniqueSubstrings)
			}
			return
		}

		for i := start; i < len(s); i++ {
			sub := s[start : i+1]
			if !uniqueSubstrings[sub] {
				uniqueSubstrings[sub] = true
				backtrack(i + 1)
				delete(uniqueSubstrings, sub)
			}
		}
	}

	backtrack(0)
	return maxCount
}