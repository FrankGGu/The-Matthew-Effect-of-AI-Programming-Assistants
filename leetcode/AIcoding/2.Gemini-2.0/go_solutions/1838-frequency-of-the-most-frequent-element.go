import "sort"

func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)
	left, right := 0, 0
	sum := 0
	ans := 0
	for right < len(nums) {
		sum += nums[right]
		for (right-left+1)*nums[right]-sum > k {
			sum -= nums[left]
			left++
		}
		ans = max(ans, right-left+1)
		right++
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}