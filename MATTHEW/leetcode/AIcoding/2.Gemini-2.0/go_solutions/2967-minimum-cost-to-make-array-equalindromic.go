import (
	"fmt"
	"sort"
)

func minimumCost(nums []int) int64 {
	sort.Ints(nums)
	n := len(nums)
	median := nums[n/2]

	cost1 := calculateCost(nums, median)

	if n%2 == 0 {
		median2 := nums[n/2-1]
		cost2 := calculateCost(nums, median2)
		return min(cost1, cost2)
	}

	return cost1
}

func calculateCost(nums []int, target int) int64 {
	cost := int64(0)
	for _, num := range nums {
		cost += abs(int64(num - target))
	}
	return cost
}

func abs(x int64) int64 {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}