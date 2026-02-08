import (
	"sort"
)

func minIncrementForTargetMultiples(nums []int, target int) int {
	sort.Ints(nums)
	res := 0
	for i := 0; i < len(nums); i++ {
		if nums[i]%target == 0 {
			continue
		}
		res += target - nums[i]%target
	}
	return res
}