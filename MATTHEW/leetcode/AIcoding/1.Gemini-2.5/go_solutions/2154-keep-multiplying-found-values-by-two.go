func findFinalValue(nums []int, original int) int {
	numSet := make(map[int]bool)
	for _, num := range nums {
		numSet[num] = true
	}

	for {
		if _, found := numSet[original]; found {
			original *= 2
		} else {
			break
		}
	}

	return original
}