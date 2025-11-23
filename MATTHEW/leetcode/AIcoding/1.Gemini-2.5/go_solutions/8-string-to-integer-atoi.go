package solution

import (
	"math"
	"strings"
)

func myAtoi(s string) int {
	s = strings.TrimLeft(s, " ")

	if len(s) == 0 {
		return 0
	}

	sign := 1
	i := 0

	if s[0] == '-' {
		sign = -1
		i++
	} else if s[0] == '+' {
		i++
	}

	var result int
	maxInt32 := math.MaxInt32
	minInt32 := math.MinInt32

	for i < len(s) && s[i] >= '0' && s[i] <= '9' {
		digit := int(s[i] - '0')

		if sign == 1 {
			if result > maxInt32/10 || (result == maxInt32/10 && digit > 7) {
				return maxInt32
			}
		} else { // sign == -1
			// For negative numbers, the maximum absolute value is 2147483648 (MinInt32).
			// MaxInt32 is 2147483647.
			// So, if result is 214748364 (MaxInt32/10) and digit is 8,
			// result*10+digit = 2147483648. This is -MinInt32, which is valid.
			// If digit is 9, it overflows.
			if result > maxInt32/10 || (result == maxInt32/10 && digit > 8) {
				return minInt32
			}
		}

		result = result*10 + digit
		i++
	}

	return sign * result
}