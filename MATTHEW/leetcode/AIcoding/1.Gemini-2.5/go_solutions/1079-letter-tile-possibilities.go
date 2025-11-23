package main

func numTilePossibilities(tiles string) int {
	counts := [26]int{}
	for _, char := range tiles {
		counts[char-'A']++
	}

	result := make(map[string]bool)

	var backtrack func(current string, currentCounts [26]int)
	backtrack = func(current string, currentCounts [26]int) {
		if current != "" {
			result[current] = true
		}

		for i := 0; i < 26; i++ {
			if currentCounts[i] > 0 {
				currentCounts[i]--
				backtrack(current+string(rune('A'+i)), currentCounts)
				currentCounts[i]++
			}
		}
	}

	backtrack("", counts)

	return len(result)
}