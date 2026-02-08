func countPairs(nums []int) int64 {
	n := len(nums)
	var ans int64
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if nums[i] <= nums[j] {
				ans++
			}
		}
	}
	return ans
}