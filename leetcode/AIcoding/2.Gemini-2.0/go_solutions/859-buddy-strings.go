func buddyStrings(s string, goal string) bool {
	if len(s) != len(goal) {
		return false
	}

	if s == goal {
		counts := make(map[rune]int)
		for _, r := range s {
			counts[r]++
			if counts[r] > 1 {
				return true
			}
		}
		return false
	}

	diff := []int{}
	for i := range s {
		if s[i] != goal[i] {
			diff = append(diff, i)
		}
	}

	if len(diff) != 2 {
		return false
	}

	return s[diff[0]] == goal[diff[1]] && s[diff[1]] == goal[diff[0]]
}