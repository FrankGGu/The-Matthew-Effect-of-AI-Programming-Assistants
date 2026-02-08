func maximumStrongPairXor(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			if nums[j] > 2*nums[i] {
				break
			}
			ans = max(ans, nums[i]^nums[j])
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}