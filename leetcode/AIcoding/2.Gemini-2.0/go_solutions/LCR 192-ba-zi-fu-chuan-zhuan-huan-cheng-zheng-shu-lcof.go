import "math"

func myAtoi(s string) int {
	i := 0
	for i < len(s) && s[i] == ' ' {
		i++
	}

	if i == len(s) {
		return 0
	}

	sign := 1
	if s[i] == '+' {
		i++
	} else if s[i] == '-' {
		sign = -1
		i++
	}

	res := 0
	for i < len(s) && s[i] >= '0' && s[i] <= '9' {
		digit := int(s[i] - '0')
		if res > math.MaxInt32/10 || (res == math.MaxInt32/10 && digit > 7) {
			if sign == 1 {
				return math.MaxInt32
			} else {
				return math.MinInt32
			}
		}
		res = res*10 + digit
		i++
	}

	return sign * res
}