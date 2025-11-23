package main

import (
	"sort"
)

func min(a, b, c, d int) int {
	res := a
	if b < res {
		res = b
	}
	if c < res {
		res = c
	}
	if d < res {
		res = d
	}
	return res
}

func getBiggestThree(grid [][]int) []int {
	m := len(grid)
	n := len(grid[0])
	uniqueSums := make(map[int]bool)

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			uniqueSums[grid[r][c]] = true

			maxK := min(r, m-1-r, c, n-1-c)

			for k := 1; k <= maxK; k++ {
				currentSum := 0
				for i := 0; i <= k; i++ {
					currentSum += grid[r-k+i][c+i]
				}
				for i := 1; i <= k; i++ {
					currentSum += grid[r+i][c+k-i]
				}
				for i := 1; i <= k; i++ {
					currentSum += grid[r+k-i][c-i]
				}
				for i := 1; i < k; i++ {
					currentSum += grid[r-i][c-k+i]
				}
				uniqueSums[currentSum] = true
			}
		}
	}

	sumsSlice := make([]int, 0, len(uniqueSums))
	for sum := range uniqueSums {
		sumsSlice = append(sumsSlice, sum)
	}

	sort.Slice(sumsSlice, func(i, j int) bool {
		return sumsSlice[i] > sumsSlice[j]
	})

	if len(sumsSlice) > 3 {
		return sumsSlice[:3]
	}
	return sumsSlice
}