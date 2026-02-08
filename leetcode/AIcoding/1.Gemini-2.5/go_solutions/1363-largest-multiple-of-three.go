func largestMultipleOfThree(digits []int) string {
	counts := make([]int, 10)
	totalSum := 0
	for _, digit := range digits {
		counts[digit]++
		totalSum += digit
	}