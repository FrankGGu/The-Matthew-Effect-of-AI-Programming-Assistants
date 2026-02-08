func maximumSum(nums []int) int64 {
	n := len(nums)
	ans := int64(0)
	for i := 1; i*i <= n; i++ {
		sum := 0
		for j := i * i; j <= n; j += i * i {
			sum += nums[j-1]
		}
		ans = max(ans, int64(sum))
	}
	return ans
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}