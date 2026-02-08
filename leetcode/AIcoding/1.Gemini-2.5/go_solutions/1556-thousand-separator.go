import (
	"strconv"
	"strings"
)

func thousandSeparator(n int) string {
	s := strconv.Itoa(n)
	l := len(s)

	if l <= 3 {
		return s
	}

	var sb strings.Builder

	firstGroupLen := l % 3
	if firstGroupLen == 0 {
		firstGroupLen = 3
	}

	sb.WriteString(s[:firstGroupLen])

	for i := firstGroupLen; i < l; i += 3 {
		sb.WriteByte('.')
		sb.WriteString(s[i : i+3])
	}

	return sb.String()
}