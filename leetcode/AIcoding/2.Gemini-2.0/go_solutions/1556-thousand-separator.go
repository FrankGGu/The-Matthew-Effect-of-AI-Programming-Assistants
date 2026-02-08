import (
	"strings"
)

func thousandSeparator(n int) string {
	s := ""
	if n == 0 {
		return "0"
	}
	count := 0
	for n > 0 {
		digit := n % 10
		s = string(rune('0'+digit)) + s
		n /= 10
		count++
		if count == 3 && n > 0 {
			s = "." + s
			count = 0
		}
	}
	return s
}