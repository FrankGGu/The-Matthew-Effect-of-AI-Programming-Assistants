func maxNonOverlapping(nums []int, target int) int {
	count := 0
	currentSum := 0
	seen := make(map[int]bool)
	seen[0] = true

	for _, num := range nums {
		currentSum += num
		if seen[currentSum-target] {
			count++
			seen = make(map[int]bool)
			seen[0] = true
			currentSum = 0
		} else {
			seen[currentSum] = true
		}
	}

	return count
}