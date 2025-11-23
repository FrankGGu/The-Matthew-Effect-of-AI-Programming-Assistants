import (
	"strings"
)

func reformatNumber(number string) string {
	digits := strings.ReplaceAll(number, " ", "")
	digits = strings.ReplaceAll(digits, "-", "")

	n := len(digits)
	result := ""
	i := 0

	for i < n-4 {
		result += digits[i:i+3] + "-"
		i += 3
	}

	if n-i == 2 {
		result += digits[i:]
	} else if n-i == 3 {
		result += digits[i:]
	} else {
		result += digits[i:i+2] + "-" + digits[i+2:]
	}

	return result
}