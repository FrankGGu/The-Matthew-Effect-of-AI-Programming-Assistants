import "sort"

func maximumGap(nums []int) int {
	n := len(nums)
	if n < 2 {
		return 0
	}
	sort.Ints(nums)
	maxGap := 0
	for i := 1; i < n; i++ {
		gap := nums[i] - nums[i-1]
		if gap > maxGap {
			maxGap = gap
		}
	}
	return maxGap
}