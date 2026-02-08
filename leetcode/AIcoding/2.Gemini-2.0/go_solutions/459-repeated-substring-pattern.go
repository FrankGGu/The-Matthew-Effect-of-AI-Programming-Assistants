import "strings"

func repeatedSubstringPattern(s string) bool {
	n := len(s)
	for i := 1; i <= n/2; i++ {
		if n%i == 0 {
			sub := s[:i]
			repeated := strings.Repeat(sub, n/i)
			if repeated == s {
				return true
			}
		}
	}
	return false
}