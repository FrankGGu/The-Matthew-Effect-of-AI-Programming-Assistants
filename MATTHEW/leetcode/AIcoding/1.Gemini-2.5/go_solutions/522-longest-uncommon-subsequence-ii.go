func findLUSlength(strs []string) int {
	counts := make(map[string]int)
	for _, s := range strs {
		counts[s]++
	}

	maxLength := -1

	for i, s1 := range strs {
		if counts[s1] > 1 {
			continue
		}

		isUncommon := true
		for j, s2 := range strs {
			if i == j {
				continue
			}
			if isSubsequence(s1, s2) {
				isUncommon = false
				break
			}
		}

		if isUncommon {
			if len(s1) > maxLength {
				maxLength = len(s1)
			}
		}
	}

	return maxLength
}

func isSubsequence(s, t string) bool {
	i, j := 0, 0
	for i < len(s) && j < len(t) {
		if s[i] == t[j] {
			i++
		}
		j++
	}
	return i == len(s)
}