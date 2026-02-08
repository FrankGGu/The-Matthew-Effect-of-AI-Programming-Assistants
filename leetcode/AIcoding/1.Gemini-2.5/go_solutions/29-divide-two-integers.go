package main

import "math"

func divide(dividend int, divisor int) int {
	if dividend == math.MinInt32 && divisor == -1 {
		return math.MaxInt32
	}

	isNegative := (dividend < 0) != (divisor < 0)

	dvd := int64(math.Abs(float64(dividend)))
	dvs := int64(math.Abs(float64(divisor)))

	quotient := int64(0)

	for dvd >= dvs {
		tempDivisor := dvs
		multiple := int64(1)
		for dvd >= (tempDivisor << 1) {
			tempDivisor <<= 1
			multiple <<= 1
		}
		dvd -= tempDivisor
		quotient += multiple
	}

	if isNegative {
		quotient = -quotient
	}

	return int(quotient)
}