func maxFrequency(nums []int, k int) int {
	n := len(nums)
	sort.Ints(nums)
	left := 0
	total := 0
	ans := 0
	for right := 0; right < n; right++ {
		total += nums[right]
		for (right-left+1)*nums[right]-total > k {
			total -= nums[left]
			left++
		}
		ans = max(ans, right-left+1)
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}