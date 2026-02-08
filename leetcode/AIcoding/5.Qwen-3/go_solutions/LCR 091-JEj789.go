package main

func minCostII(costs [][]int) int {
	if len(costs) == 0 {
		return 0
	}
	n := len(costs)
	m := len(costs[0])
	for i := 1; i < n; i++ {
		for j := 0; j < m; j++ {
			minPrev := 1<<31 - 1
			for k := 0; k < m; k++ {
				if k != j {
					if costs[i-1][k] < minPrev {
						minPrev = costs[i-1][k]
					}
				}
			}
			costs[i][j] += minPrev
		}
	}
	min := 1<<31 - 1
	for i := 0; i < m; i++ {
		if costs[n-1][i] < min {
			min = costs[n-1][i]
		}
	}
	return min
}