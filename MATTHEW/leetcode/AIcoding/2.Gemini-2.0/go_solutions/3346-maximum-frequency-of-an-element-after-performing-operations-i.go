import "sort"

func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)
	l, r := 0, 0
	total := 0
	res := 0
	for r < len(nums) {
		total += nums[r]
		for (r-l+1)*nums[r]-total > k {
			total -= nums[l]
			l++
		}
		res = max(res, r-l+1)
		r++
	}
	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}