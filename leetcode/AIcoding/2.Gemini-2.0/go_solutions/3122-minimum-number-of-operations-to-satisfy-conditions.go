func minOperations(nums []int, k int) int {
	n := len(nums)
	count := 0
	for i := 0; i < n; i++ {
		if nums[i] < k {
			count++
		}
	}
	return count
}