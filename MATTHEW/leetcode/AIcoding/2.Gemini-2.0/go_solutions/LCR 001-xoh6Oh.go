func divide(dividend int, divisor int) int {
	if dividend == 0 {
		return 0
	}
	if divisor == 1 {
		return dividend
	}
	if divisor == -1 {
		if dividend == -2147483648 {
			return 2147483647
		}
		return -dividend
	}

	sign := 1
	if (dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0) {
		sign = -1
	}

	dividendAbs := abs(dividend)
	divisorAbs := abs(divisor)

	if dividendAbs < divisorAbs {
		return 0
	}

	result := 0
	for dividendAbs >= divisorAbs {
		shift := 0
		for (divisorAbs << (shift + 1)) <= dividendAbs && shift < 31 {
			shift++
		}
		result += 1 << shift
		dividendAbs -= divisorAbs << shift
	}

	if sign == -1 {
		result = -result
	}

	if result > 2147483647 {
		return 2147483647
	}
	if result < -2147483648 {
		return -2147483648
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}