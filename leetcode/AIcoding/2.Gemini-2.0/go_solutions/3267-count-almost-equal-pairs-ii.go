import "sort"

func countAlmostEqualPairs(nums []int, diff int) int64 {
	n := len(nums)
	sort.Ints(nums)
	var count int64
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if abs(nums[i]-nums[j]) <= diff {
				count++
			} else if nums[j]-nums[i] > diff {
				break
			}
		}
	}
	return count
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}