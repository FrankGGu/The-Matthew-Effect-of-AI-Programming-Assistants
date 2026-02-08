import "strings"

func repeatedStringMatch(a string, b string) int {
	n := len(a)
	m := len(b)

	for i := 1; i <= m/n+3; i++ {
		s := strings.Repeat(a, i)
		if strings.Contains(s, b) {
			return i
		}
	}
	return -1
}