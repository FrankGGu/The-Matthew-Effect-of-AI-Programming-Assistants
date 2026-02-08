func fractionToDecimal(numerator int, denominator int) string {
	if numerator == 0 {
		return "0"
	}

	sign := ""
	if (numerator < 0) != (denominator < 0) {
		sign = "-"
	}

	numerator = abs(numerator)
	denominator = abs(denominator)

	integerPart := numerator / denominator
	remainder := numerator % denominator

	if remainder == 0 {
		return sign + strconv.Itoa(integerPart)
	}

	result := sign + strconv.Itoa(integerPart) + "."

	remainderMap := make(map[int]int)
	decimalPart := ""
	index := 0

	for remainder != 0 {
		if i, ok := remainderMap[remainder]; ok {
			decimalPart = decimalPart[:i] + "(" + decimalPart[i:] + ")"
			return result + decimalPart
		}

		remainderMap[remainder] = index
		remainder *= 10
		decimalPart += strconv.Itoa(remainder / denominator)
		remainder %= denominator
		index++
	}

	return result + decimalPart
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

import "strconv"