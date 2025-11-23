package main

import (
	"sort"
)

func minOperations(grid [][]int, x int) int {
	m := len(grid)
	n := len(grid[0])

	flatNums := make([]int, 0, m*n)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			flatNums = append(flatNums, grid[i][j])
		}
	}

	firstRemainder := flatNums[0] % x
	for i := 1; i < len(flatNums); i++ {
		if flatNums[i]%x != firstRemainder {
			return -1
		}
	}

	sort.Ints(flatNums)

	target := flatNums[len(flatNums)/2]

	operations := 0
	for _, num := range flatNums {
		diff := num - target
		if diff < 0 {
			diff = -diff
		}
		operations += diff / x
	}

	return operations
}