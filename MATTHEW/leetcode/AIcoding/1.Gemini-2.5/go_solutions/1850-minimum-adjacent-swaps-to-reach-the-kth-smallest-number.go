func getMinSwaps(num string, k int) int {
	originalNumDigits := []byte(num)
	targetNumDigits := make([]byte, len(num))
	copy(targetNumDigits, originalNumDigits)

	// Step 1: Find the k-th lexicographically smallest number greater than num
	for i := 0