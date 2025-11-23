func divide(dividend int, divisor int) int {
	if dividend == -2147483648 && divisor == -1 {
		return 2147483647
	}
	sign := 1
	if (dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0) {
		sign = -1
	}
	if dividend < 0 {
		dividend = -dividend
	}
	if divisor < 0 {
		divisor = -divisor
	}
	quotient := 0
	for dividend >= divisor {
		temp := divisor
		multiple := 1
		for dividend >= temp<<1 {
			if temp > 1073741823 {
				break
			}
			temp <<= 1
			multiple <<= 1
		}
		dividend -= temp
		quotient += multiple
	}
	return sign * quotient
}