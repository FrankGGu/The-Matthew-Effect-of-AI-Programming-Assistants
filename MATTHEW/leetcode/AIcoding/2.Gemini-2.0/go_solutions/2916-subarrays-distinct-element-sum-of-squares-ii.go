import (
	"container/list"
)

func sumCounts(nums []int) int {
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		distinct := make(map[int]bool)
		for j := i; j < n; j++ {
			distinct[nums[j]] = true
			distinctCount := len(distinct)
			ans += distinctCount * distinctCount
		}
	}
	return ans
}