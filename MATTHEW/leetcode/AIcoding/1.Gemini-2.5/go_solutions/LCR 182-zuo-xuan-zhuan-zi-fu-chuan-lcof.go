import (
	"strings"
)

func dynamicPassword(s string, n int) string {
	var builder strings.Builder
	builder.Grow(len(s))

	shift := n % 26

	for _, r := range s {
		pos := int(r - 'a')
		newPos := (pos + shift + 26) % 26
		builder.WriteRune(rune('a' + newPos))
	}

	return builder.String()
}