func divisibilityArray(word string, m int) []int {
	n := len(word)
	result := make([]int, n)
	remainder := 0
	for i := 0; i < n; i++ {
		digit := int(word[i] - '0')
		remainder = (remainder*10 + digit) % m
		if remainder == 0 {
			result[i] = 1
		} else {
			result[i] = 0
		}
	}
	return result
}