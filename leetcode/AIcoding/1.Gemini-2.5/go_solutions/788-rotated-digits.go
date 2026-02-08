package main

func rotatedDigits(n int) int {
	count := 0
	for i := 1; i <= n; i++ {
		num := i
		hasRotatedDiff := false
		isValidRotation := true

		for num > 0 {
			digit := num % 10
			if digit == 3 || digit == 4 || digit == 7 {
				isValidRotation = false
				break
			}
			if digit == 2 || digit == 5 || digit == 6 || digit == 9 {
				hasRotatedDiff = true
			}
			num /= 10
		}

		if isValidRotation && hasRotatedDiff {
			count++
		}
	}
	return count
}