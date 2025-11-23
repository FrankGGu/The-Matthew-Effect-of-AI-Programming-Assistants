import "strings"

func countSegments(s string) int {
	s = strings.TrimSpace(s)
	if len(s) == 0 {
		return 0
	}
	return len(strings.Fields(s))
}