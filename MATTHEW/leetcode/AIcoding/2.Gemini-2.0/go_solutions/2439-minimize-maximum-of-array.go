func minimizeArrayValue(nums []int) int {
	n := len(nums)
	sum := 0
	ans := 0
	for i := 0; i < n; i++ {
		sum += nums[i]
		ans = max(ans, (sum+i)/(i+1))
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}