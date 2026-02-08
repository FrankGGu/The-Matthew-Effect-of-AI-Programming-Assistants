func longestValidSubstring(word string, forbidden []string) int {
	forbiddenSet := make(map[string]bool)
	for _, s := range forbidden {
		forbiddenSet[s] = true
	}

	n := len(word)
	maxLen := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := word[i : j+1]
			valid := true
			for k := 0; k <= len(sub); k++ {
				for l := k + 1; l <= len(sub); l++ {
					if forbiddenSet[sub[k:l]] {
						valid = false
						break
					}
				}
				if !valid {
					break
				}
			}
			if valid {
				if len(sub) > maxLen {
					maxLen = len(sub)
				}
			}
		}
	}
	return maxLen
}