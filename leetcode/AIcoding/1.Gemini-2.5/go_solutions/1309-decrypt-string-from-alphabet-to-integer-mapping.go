import (
	"strconv"
	"strings"
)

func freqAlphabets(s string) string {
	var builder strings.Builder
	n := len(s)
	i := 0
	for i < n {
		// Check if it's a two-digit number followed by '#'
		// This requires checking if there are at least 3 characters remaining (digit, digit, #)
		if i+2 < n && s[i+2] == '#' {
			// Extract the two-digit number string
			numStr := s[i : i+2]
			num, _ := strconv.Atoi(numStr)
			// Convert to character and append
			builder.WriteByte(byte('a' + num - 1))
			// Advance index past the two digits and '#'
			i += 3
		} else {
			// It's a single-digit number
			// Convert to character and append
			num := s[i] - '0'
			builder.WriteByte(byte('a' + num - 1))
			// Advance index past the single digit
			i += 1
		}
	}
	return builder.String()
}