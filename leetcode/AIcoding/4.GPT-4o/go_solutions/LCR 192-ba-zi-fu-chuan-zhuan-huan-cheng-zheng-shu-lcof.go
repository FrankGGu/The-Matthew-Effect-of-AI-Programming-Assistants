package main

import (
	"math"
	"strings"
)

func myAtoi(s string) int {
	s = strings.TrimSpace(s)
	if len(s) == 0 {
		return 0
	}

	sign, index, total := 1, 0, 0
	if s[0] == '-' {
		sign = -1
		index++
	} else if s[0] == '+' {
		index++
	}

	for index < len(s) {
		digit := s[index] - '0'
		if digit < 0 || digit > 9 {
			break
		}
		if total > (math.MaxInt32-digit)/10 {
			if sign == 1 {
				return math.MaxInt32
			}
			return math.MinInt32
		}
		total = total*10 + int(digit)
		index++
	}

	return total * sign
}