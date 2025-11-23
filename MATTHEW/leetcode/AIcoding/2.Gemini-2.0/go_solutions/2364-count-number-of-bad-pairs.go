func countBadPairs(nums []int) int64 {
	n := len(nums)
	count := int64(0)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if nums[j]-nums[i] != j-i {
				count++
			}
		}
	}
	return count
}