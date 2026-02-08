import "strings"

func shiftDistance(s string, t string) int {
	if len(s) != len(t) {
		return -1
	}
	if len(s) == 0 {
		return 0
	}

	doubledS := s + s

	idx := strings.Index(doubledS, t)

	return idx
}