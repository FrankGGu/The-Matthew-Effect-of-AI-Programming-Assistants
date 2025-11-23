func minOperations(nums []int) int {
	seen := make(map[int]bool)
	for _, num := range nums {
		if num > 0 {
			seen[num] = true
		}
	}
	return len(seen)
}