package solution

import (
	"strings"
)

func convertToBase7(num int) string {
	if num == 0 {
		return "0"
	}

	isNegative := false
	if num < 0 {
		isNegative = true
		num = -num
	}

	var sb strings.Builder
	for num > 0 {
		digit := num % 7
		sb.WriteByte(byte(digit + '0'))
		num /= 7
	}

	s := sb.String()
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}

	result := string(runes)

	if isNegative {
		return "-" + result
	}
	return result
}