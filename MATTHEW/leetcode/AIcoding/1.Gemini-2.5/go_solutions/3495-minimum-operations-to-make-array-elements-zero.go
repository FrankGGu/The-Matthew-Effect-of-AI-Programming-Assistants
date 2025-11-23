func minimumOperations(nums []int) int {
	uniquePositive := make(map[int]bool)

	for _, num := range nums {
		if num > 0 {
			uniquePositive[num] = true
		}
	}

	return len(uniquePositive)
}