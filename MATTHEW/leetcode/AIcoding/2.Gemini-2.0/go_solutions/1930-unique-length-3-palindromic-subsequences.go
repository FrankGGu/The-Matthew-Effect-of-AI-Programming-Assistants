func countPalindromicSubsequence(s string) int {
	first := make(map[rune]int)
	last := make(map[rune]int)

	for i, r := range s {
		if _, ok := first[r]; !ok {
			first[r] = i
		}
		last[r] = i
	}

	count := 0
	seen := make(map[string]bool)

	for r := 'a'; r <= 'z'; r++ {
		if _, ok := first[r]; !ok {
			continue
		}

		for mid := 'a'; mid <= 'z'; mid++ {
			if first[r] < last[r] {
				for i := first[r] + 1; i < last[r]; i++ {
					if rune(s[i]) == mid {
						key := string(r) + string(mid)
						if !seen[key] {
							count++
							seen[key] = true
						}
						break
					}
				}
			}
		}
	}

	return count
}