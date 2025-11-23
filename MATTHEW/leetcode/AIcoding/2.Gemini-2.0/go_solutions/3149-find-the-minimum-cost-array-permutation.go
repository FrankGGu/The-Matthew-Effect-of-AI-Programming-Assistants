import (
	"sort"
)

func minCost(nums []int, costs []int) int64 {
	n := len(nums)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return nums[indices[i]] < nums[indices[j]]
	})

	sortedCosts := make([]int, n)
	for i := range indices {
		sortedCosts[i] = costs[indices[i]]
	}

	return int64(calculateMinCost(sortedCosts))
}

func calculateMinCost(costs []int) int {
	n := len(costs)
	if n <= 1 {
		return 0
	}

	if n == 2 {
		return min(0, costs[0]+costs[1])
	}

	median := findMedian(costs)

	cost := 0
	for _, c := range costs {
		cost += abs(c - median)
	}

	return cost
}

func findMedian(arr []int) int {
	arrCopy := make([]int, len(arr))
	copy(arrCopy, arr)
	sort.Ints(arrCopy)
	return arrCopy[len(arrCopy)/2]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}