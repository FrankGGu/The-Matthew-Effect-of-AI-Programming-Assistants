func countNumbersWithUniqueDigits(n int) int {
	if n == 0 {
		return 1
	}

	ans := 10
	currentProduct := 9

	for k := 2; k <= n; k++ {
		currentProduct *= (10 - k + 1)
		ans += currentProduct
	}

	return ans
}