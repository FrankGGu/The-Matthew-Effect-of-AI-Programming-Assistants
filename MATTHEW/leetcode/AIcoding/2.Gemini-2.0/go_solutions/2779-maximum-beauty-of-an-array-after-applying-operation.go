import "sort"

func maximumBeauty(nums []int, k int) int {
	sort.Ints(nums)
	left, right := 0, 0
	ans := 0
	for right < len(nums) {
		for nums[right]-nums[left] > 2*k {
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