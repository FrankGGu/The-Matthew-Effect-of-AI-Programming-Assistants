func twoCitySchedCost(costs [][]int) int {
	sort.Slice(costs, func(i, j int) bool {
		return (costs[i][0] - costs[i][1]) < (costs[j][0] - costs[j][1])
	})

	totalCost := 0
	n := len(costs)

	for i := 0; i < n/2; i++ {
		totalCost += costs[i][0]
	}

	for i := n/2; i < n; i++ {
		totalCost += costs[i][1]
	}

	return totalCost
}