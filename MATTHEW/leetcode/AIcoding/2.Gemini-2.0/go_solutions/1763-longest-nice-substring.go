import "strings"

func longestNiceSubstring(s string) string {
	if len(s) < 2 {
		return ""
	}

	for i := 0; i < len(s); i++ {
		if strings.Contains(s[i+1:], string(rune(s[i]^32))) {
			continue
		} else {
			left := longestNiceSubstring(s[:i])
			right := longestNiceSubstring(s[i+1:])
			if len(left) >= len(right) {
				return left
			} else {
				return right
			}
		}
	}
	return s
}