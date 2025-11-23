import "sort"

func maximumSpending(costs [][]int) int64 {
	m := len(costs)
	n := len(costs[0])
	spent := int64(0)
	indices := make([]int, m)
	for i := 0; i < m; i++ {
		indices[i] = n - 1
	}

	for day := 0; day < m*n; day++ {
		maxCost := -1
		maxIndex := -1
		for i := 0; i < m; i++ {
			if indices[i] >= 0 && costs[i][indices[i]] > maxCost {
				maxCost = costs[i][indices[i]]
				maxIndex = i
			}
		}
		spent += int64(maxCost)
		indices[maxIndex]--
	}

	return spent
}