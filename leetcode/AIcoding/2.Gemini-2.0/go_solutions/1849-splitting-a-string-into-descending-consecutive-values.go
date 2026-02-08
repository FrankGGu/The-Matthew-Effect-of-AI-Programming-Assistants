import (
	"strconv"
)

func splittingString(s string) bool {
	var backtrack func(string, int64) bool

	backtrack = func(str string, prev int64) bool {
		if len(str) == 0 {
			return true
		}

		for i := 1; i <= len(str); i++ {
			currStr := str[:i]
			curr, _ := strconv.ParseInt(currStr, 10, 64)

			if prev == -1 || curr == prev-1 {
				if backtrack(str[i:], curr) {
					return true
				}
			}
		}
		return false
	}

	for i := 1; i < len(s); i++ {
		firstStr := s[:i]
		first, _ := strconv.ParseInt(firstStr, 10, 64)
		if backtrack(s[i:], first) {
			return true
		}
	}
	return false
}