func divisibilityArray(word string, m int) []int {
	n := len(word)
	ans := make([]int, n)

	currentRemainder := 0

	for i := 0; i < n; i++ {
		digit := int(word[i] - '0')
		currentRemainder = (currentRemainder*10 + digit) % m

		if currentRemainder == 0 {
			ans[i] = 1
		} else {
			ans[i] = 0
		}
	}

	return ans
}