import (
	"strings"
)

func maxValue(n string, x int) string {
	charX := byte(x + '0')
	isNegative := n[0] == '-'

	var builder strings.Builder
	inserted := false

	if isNegative {
		builder.WriteByte('-')
		for i := 1; i < len(n); i++ {
			if !inserted && charX < n[i] {
				builder.WriteByte(charX)
				inserted = true
			}
			builder.WriteByte(n[i])
		}
	} else {
		for i := 0; i < len(n); i++ {
			if !inserted && charX > n[i] {
				builder.WriteByte(charX)
				inserted = true
			}
			builder.WriteByte(n[i])
		}
	}

	if !inserted {
		builder.WriteByte(charX)
	}

	return builder.String()
}