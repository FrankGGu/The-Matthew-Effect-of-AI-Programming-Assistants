func maxLength(arr []string) int {
	dp := []string{""}
	ans := 0
	for _, s := range arr {
		if !isUnique(s) {
			continue
		}
		for _, prev := range dp {
			combined := prev + s
			if isUnique(combined) {
				dp = append(dp, combined)
				if len(combined) > ans {
					ans = len(combined)
				}
			}
		}
	}
	return ans
}

func isUnique(s string) bool {
	seen := make(map[rune]bool)
	for _, r := range s {
		if seen[r] {
			return false
		}
		seen[r] = true
	}
	return true
}