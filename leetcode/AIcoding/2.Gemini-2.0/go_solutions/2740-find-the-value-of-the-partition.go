import "sort"

func findValueOfPartition(nums []int) int {
	sort.Ints(nums)
	minDiff := int(1e9 + 7)
	for i := 0; i < len(nums)-1; i++ {
		diff := nums[i+1] - nums[i]
		if diff < minDiff {
			minDiff = diff
		}
	}
	return minDiff
}