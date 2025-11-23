func rotatedDigits(n int) int {
	count := 0
	for i := 1; i <= n; i++ {
		if isValid(i) {
			count++
		}
	}
	return count
}

func isValid(n int) bool {
	rotated := false
	for n > 0 {
		digit := n % 10
		if digit == 2 || digit == 5 || digit == 6 || digit == 9 {
			rotated = true
		} else if digit == 3 || digit == 4 || digit == 7 {
			return false
		}
		n /= 10
	}
	return rotated
}