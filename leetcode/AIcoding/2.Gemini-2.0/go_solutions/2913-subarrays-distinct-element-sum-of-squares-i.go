func sumCounts(nums []int) int {
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			distinct := make(map[int]bool)
			for k := i; k <= j; k++ {
				distinct[nums[k]] = true
			}
			count := len(distinct)
			ans += count * count
		}
	}
	return ans
}