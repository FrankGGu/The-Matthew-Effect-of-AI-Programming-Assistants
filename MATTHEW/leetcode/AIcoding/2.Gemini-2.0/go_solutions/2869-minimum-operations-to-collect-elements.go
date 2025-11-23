func minOperations(nums []int, k int) int {
	n := len(nums)
	seen := make(map[int]bool)
	count := 0
	ops := 0
	for i := n - 1; i >= 0; i-- {
		ops++
		if nums[i] <= k {
			if !seen[nums[i]] {
				seen[nums[i]] = true
				count++
			}
		}
		if count == k {
			return ops
		}
	}
	return ops
}