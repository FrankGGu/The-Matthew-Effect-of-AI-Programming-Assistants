func countBeautifulPairs(nums []int) int {
	count := 0
	n := len(nums)

	for i := 0; i < n; i++ {
		firstDigitI := nums[i]
		for firstDigitI >= 10 {
			firstDigitI /= 10
		}

		for j := i + 1; j < n; j++ {
			lastDigitJ := nums[j] % 10

			if gcd(firstDigitI, lastDigitJ) == 1 {
				count++
			}
		}
	}
	return count
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}