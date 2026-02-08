import "sort"

func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)
	left, right := 0, 0
	res := 0
	total := 0
	for right < len(nums) {
		total += nums[right]
		for (right-left+1)*nums[right]-total > k {
			total -= nums[left]
			left++
		}
		res = max(res, right-left+1)
		right++
	}
	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}