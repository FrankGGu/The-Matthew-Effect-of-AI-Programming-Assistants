func smallestNumber(num int64) int64 {
	if num == 0 {
		return 0
	}

	isNegative := num < 0
	if isNegative {
		num = -num // Work with the positive absolute value
	}

	s := strconv.FormatInt(num, 10)
	digits := []byte(s)

	if isNegative {
		// For negative numbers, we want the largest possible number formed by digits
		// to make the overall negative number smallest (e.g., -123 -> -321).
		// So, sort digits in descending order.
		sort.Slice(digits, func(i, j int) bool {
			return digits[i] > digits[j]
		})
	} else {
		// For positive numbers, we want the smallest possible number.
		// Sort digits in ascending order.
		sort.Slice(digits, func(i, j int) bool {
			return digits[i] < digits[j]
		})

		// Handle leading zero for positive numbers:
		// If the first digit is '0' and there are other digits,
		// find the first non-zero digit and swap it with the '0'.
		if digits[0] == '0' {
			for i := 1; i < len(digits); i++ {
				if digits[i] != '0' {
					digits[0], digits[i] = digits[i], digits[0]
					break
				}
			}
		}
	}

	resultStr := string(digits)
	result, _ := strconv.ParseInt(resultStr, 10, 64)

	if isNegative {
		return -result
	}
	return result
}