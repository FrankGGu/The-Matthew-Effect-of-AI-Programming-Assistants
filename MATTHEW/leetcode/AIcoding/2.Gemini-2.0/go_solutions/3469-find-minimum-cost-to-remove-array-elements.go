import (
	"math"
)

func minCost(nums []int, cost []int) int64 {
	n := len(nums)
	l, r := 0, 1000001
	for l < r {
		mid := (l + r) / 2
		cost1 := calculateCost(nums, cost, mid)
		cost2 := calculateCost(nums, cost, mid+1)
		if cost1 < cost2 {
			r = mid
		} else {
			l = mid + 1
		}
	}
	return calculateCost(nums, cost, l)
}

func calculateCost(nums []int, cost []int, target int) int64 {
	var res int64
	for i := 0; i < len(nums); i++ {
		res += int64(math.Abs(float64(nums[i]-target))) * int64(cost[i])
	}
	return res
}