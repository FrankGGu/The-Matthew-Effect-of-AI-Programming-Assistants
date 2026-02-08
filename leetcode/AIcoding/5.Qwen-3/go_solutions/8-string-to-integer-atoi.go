package main

import (
	"math"
)

func myAtoi(s string) int {
	if len(s) == 0 {
		return 0
	}

	var i int
	for i < len(s) && s[i] == ' ' {
		i++
	}

	sign := 1
	if i < len(s) && s[i] == '-' {
		sign = -1
		i++
	} else if i < len(s) && s[i] == '+' {
		i++
	}

	var result int64
	for i < len(s) && '0' <= s[i] && s[i] <= '9' {
		digit := int64(s[i] - '0')
		result = result*10 + digit
		if result > math.MaxInt32 {
			if sign == 1 {
				return math.MaxInt32
			} else {
				return math.MinInt32
			}
		}
		i++
	}

	return int(result * sign)
}