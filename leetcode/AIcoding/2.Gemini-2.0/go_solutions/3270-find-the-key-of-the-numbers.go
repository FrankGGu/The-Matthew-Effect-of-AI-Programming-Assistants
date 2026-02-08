func findKey(numbers []int) int {
	n := len(numbers)
	counts := make([]int, 10)
	for _, num := range numbers {
		counts[num]++
	}

	maxCount := 0
	maxDigit := -1
	for i := 0; i < 10; i++ {
		if counts[i] > maxCount {
			maxCount = counts[i]
			maxDigit = i
		}
	}

	if maxCount > n/2 {
		return maxDigit
	}

	return -1
}