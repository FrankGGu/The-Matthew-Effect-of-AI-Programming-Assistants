package main

func fractionToDecimal(numerator int, denominator int) string {
	if numerator == 0 {
		return "0"
	}

	var result []rune
	if (numerator < 0) != (denominator < 0) {
		result = append(result, '-')
	}

	num := abs(numerator)
	den := abs(denominator)

	result = append(result, rune('0'+num/den))
	num = num % den

	if num == 0 {
		return string(result)
	}

	result = append(result, '.')

	memo := make(map[int]int)
	for num != 0 {
		if idx, ok := memo[num]; ok {
			result = append(result[:idx], append([]rune{"("}, result[idx:]...)...)
			result = append(result, ')')
			break
		}
		memo[num] = len(result)
		num *= 10
		result = append(result, rune('0'+num/den))
		num = num % den
	}

	return string(result)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}