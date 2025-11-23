func maxUniqueSplit(s string) int {
	max := 0
	var backtrack func(string, map[string]bool, int)

	backtrack = func(str string, seen map[string]bool, count int) {
		if len(str) == 0 {
			if count > max {
				max = count
			}
			return
		}

		for i := 1; i <= len(str); i++ {
			sub := str[:i]
			if _, ok := seen[sub]; !ok {
				newSeen := make(map[string]bool)
				for k, v := range seen {
					newSeen[k] = v
				}
				newSeen[sub] = true
				backtrack(str[i:], newSeen, count+1)
			}
		}
	}

	backtrack(s, make(map[string]bool), 0)
	return max
}