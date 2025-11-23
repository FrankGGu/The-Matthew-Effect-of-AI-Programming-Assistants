import "strings"

func generateTheString(n int) string {
	var sb strings.Builder
	if n%2 == 1 {
		for i := 0; i < n; i++ {
			sb.WriteByte('a')
		}
	} else {
		for i := 0; i < n-1; i++ {
			sb.WriteByte('a')
		}
		sb.WriteByte('b')
	}
	return sb.String()
}