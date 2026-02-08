package leetcode

func divide(dividend int, divisor int) int {
	if dividend == 0 {
		return 0
	}
	if divisor == 1 {
		return dividend
	}
	if divisor == -1 {
		if dividend > math.MaxInt32 {
			return math.MaxInt32
		}
		if dividend < math.MinInt32 {
			return math.MinInt32
		}
		return -dividend
	}
	sign := 1
	if (dividend < 0) != (divisor < 0) {
		sign = -1
	}
	a, b := dividend, divisor
	if a < 0 {
		a = -a
	}
	if b < 0 {
		b = -b
	}
	result := 0
	for a >= b {
		temp := b
		i := 0
		for temp <= a {
			temp <<= 1
			i++
		}
		result += 1 << (i - 1)
		a -= (1 << (i - 1)) * b
	}
	if sign == -1 {
		result = -result
	}
	if result > math.MaxInt32 {
		return math.MaxInt32
	}
	if result < math.MinInt32 {
		return math.MinInt32
	}
	return result
}