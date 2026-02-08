func applyOperations(nums []int, k int) bool {
	n := len(nums)
	diff := make([]int, n+1)
	for i := 0; i < n; i++ {
		diff[i] += nums[i]
		if diff[i] != 0 {
			if i+k > n {
				return false
			}
			diff[i+k] -= diff[i]
		}
	}
	return diff[n] == 0
}