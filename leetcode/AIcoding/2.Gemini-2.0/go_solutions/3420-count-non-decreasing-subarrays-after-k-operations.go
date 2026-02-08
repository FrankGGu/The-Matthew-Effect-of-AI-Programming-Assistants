func countNonDecreasingSubarrays(nums []int, k int) int64 {
	n := len(nums)
	ans := int64(0)
	left := 0
	for right := 0; right < n; right++ {
		operations := 0
		for i := left + 1; i <= right; i++ {
			if nums[i] < nums[i-1] {
				operations += nums[i-1] - nums[i]
			}
		}
		for operations > k && left <= right {
			operations = 0
			left++
			for i := left + 1; i <= right; i++ {
				if nums[i] < nums[i-1] {
					operations += nums[i-1] - nums[i]
				}
			}
		}
		ans += int64(right - left + 1)
	}
	return ans
}