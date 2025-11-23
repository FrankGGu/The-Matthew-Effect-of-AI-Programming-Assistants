func maxNumberOfAlloys(n int, k int, budget int, composition [][]int, stock []int, cost []int) int {
	maxAlloys := 0
	for i := 0; i < k; i++ {
		low := 0
		high := 200000000
		for low <= high {
			mid := low + (high-low)/2
			totalCost := 0
			possible := true
			for j := 0; j < n; j++ {
				needed := composition[i][j]*mid - stock[j]
				if needed > 0 {
					totalCost += needed * cost[j]
				}
				if totalCost > budget {
					possible = false
					break
				}
			}

			if possible {
				maxAlloys = max(maxAlloys, mid)
				low = mid + 1
			} else {
				high = mid - 1
			}
		}
	}
	return maxAlloys
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}