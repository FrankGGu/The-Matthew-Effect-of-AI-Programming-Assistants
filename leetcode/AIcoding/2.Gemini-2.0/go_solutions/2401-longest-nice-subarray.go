func longestNiceSubarray(nums []int) int {
	ans := 0
	mask := 0
	left := 0
	for right := 0; right < len(nums); right++ {
		for mask&nums[right] != 0 {
			mask ^= nums[left]
			left++
		}
		mask |= nums[right]
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