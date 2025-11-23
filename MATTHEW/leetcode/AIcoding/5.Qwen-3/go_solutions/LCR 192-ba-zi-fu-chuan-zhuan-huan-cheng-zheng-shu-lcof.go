package main

func myAtoi(s string) int {
	var result int
	var sign int = 1
	var i int = 0

	for i < len(s) && s[i] == ' ' {
		i++
	}

	if i < len(s) && s[i] == '-' {
		sign = -1
		i++
	} else if i < len(s) && s[i] == '+' {
		i++
	}

	for i < len(s) && s[i] >= '0' && s[i] <= '9' {
		digit := int(s[i] - '0')
		if result > (math.MaxInt32 - digit)/10 {
			if sign == 1 {
				return math.MaxInt32
			} else {
				return math.MinInt32
			}
		}
		result = result*10 + digit
		i++
	}

	return result * sign
}