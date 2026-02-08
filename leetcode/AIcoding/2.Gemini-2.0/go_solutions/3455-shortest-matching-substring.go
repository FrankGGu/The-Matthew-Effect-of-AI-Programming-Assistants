import "math"

func shortestMatchingSubstr(source string, target string) string {
	if len(target) == 0 {
		return ""
	}

	if len(source) == 0 || len(source) < len(target) {
		return ""
	}

	minLen := math.MaxInt32
	start := 0
	end := 0

	for i := 0; i <= len(source)-len(target); i++ {
		for j := i; j < len(source); j++ {
			sub := source[i : j+1]
			if len(sub) >= len(target) && isSubsequence(target, sub) {
				if len(sub) < minLen {
					minLen = len(sub)
					start = i
					end = j + 1
				}
				break
			}
		}
	}

	if minLen == math.MaxInt32 {
		return ""
	}

	return source[start:end]
}

func isSubsequence(s string, t string) bool {
	i := 0
	j := 0

	for i < len(s) && j < len(t) {
		if s[i] == t[j] {
			i++
		}
		j++
	}

	return i == len(s)
}