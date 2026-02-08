package main

import "math"

func minimumAbsoluteDifference(grid [][]int, k int) [][]int {
	m := len(grid)
	n := len(grid[0])

	if k == 1 {
		ans := make([][]int, m)
		for i := range ans {
			ans[i] = make([]int, n)
		}
		return ans
	}

	ans := make([][]int, m-k+1)
	for i := range ans {
		ans[i] = make([]int, n-k+1)
	}

	freq := make([]int, 101)

	calculateMinDiff := func() int {
		minD := math.MaxInt32
		lastVal := -1
		for val := 1; val <= 100; val++ {
			if freq[val] > 0 {
				if freq[val] > 1 {
					return 0
				}
				if lastVal != -1 {
					minD = min(minD, val-lastVal)
				}
				lastVal = val
			}
		}
		return minD
	}

	for r := 0; r <= m-k; r++ {
		if r == 0 {
			for i := 0; i < k; i++ {
				for j := 0; j < k; j++ {
					freq[grid[i][j]]++
				}
			}
		} else {
			for j := 0; j < k; j++ {
				freq[grid[r-1][j]]--
			}
			for j := 0; j < k; j++ {
				freq[grid[r+k-1][j]]++
			}
		}
		ans[r][0] = calculateMinDiff()

		for c := 1; c <= n-k; c++ {
			for i := 0; i < k; i++ {
				freq[grid[r+i][c-1]]--
			}
			for i := 0; i < k; i++ {
				freq[grid[r+i][c+k-1]]++
			}
			ans[r][c] = calculateMinDiff()
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}