func minOperations(nums []int, k int) int {
	count := 0
	for _, num := range nums {
		if num < k {
			count++
		}
	}
	return count
}