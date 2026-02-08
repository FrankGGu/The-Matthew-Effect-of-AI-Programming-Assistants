import "sort"

func findLUSlength(strs []string) int {
	sort.Slice(strs, func(i, j int) bool {
		return len(strs[i]) > len(strs[j])
	})

	isSubsequence := func(s, t string) bool {
		i, j := 0, 0
		for i < len(s) && j < len(t) {
			if s[i] == t[j] {
				i++
			}
			j++
		}
		return i == len(s)
	}

	for i := 0; i < len(strs); i++ {
		valid := true
		for j := 0; j < len(strs); j++ {
			if i == j {
				continue
			}
			if isSubsequence(strs[i], strs[j]) {
				valid = false
				break
			}
		}
		if valid {
			return len(strs[i])
		}
	}

	return -1
}