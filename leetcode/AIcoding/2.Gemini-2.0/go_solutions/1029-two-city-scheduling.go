import (
	"sort"
)

func twoCitySchedCost(costs [][]int) int {
	n := len(costs) / 2
	sort.Slice(costs, func(i, j int) bool {
		return costs[i][0]-costs[i][1] < costs[j][0]-costs[j][1]
	})

	totalCost := 0
	for i := 0; i < n; i++ {
		totalCost += costs[i][0]
	}
	for i := n; i < 2*n; i++ {
		totalCost += costs[i][1]
	}

	return totalCost
}