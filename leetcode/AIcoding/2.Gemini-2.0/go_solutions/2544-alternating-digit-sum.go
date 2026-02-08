func alternateDigitSum(n int) int {
	sum := 0
	sign := 1
	s := ""
	for n > 0 {
		s = string(rune(n%10+'0')) + s
		n /= 10
	}

	for _, r := range s {
		digit := int(r - '0')
		sum += sign * digit
		sign *= -1
	}
	return sum
}