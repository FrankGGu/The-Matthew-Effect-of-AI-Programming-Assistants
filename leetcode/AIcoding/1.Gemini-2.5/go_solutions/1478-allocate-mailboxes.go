package main

import (
	"math"
	"sort"
)

func minDistance(houses []int, k int) int {
	sort.Ints(houses)
	n := len(houses)

	costs := make([][]int, n)
	for i := range costs {
		costs[i] = make([]int, n)
		for j := i; j < n; j++ {
			mid := (i + j) / 2
			for p := i; p <= j; p++ {
				costs[i][j] += abs(houses[p] - houses[mid])
			}
		}
	}

	dp := make([][]int, k+1)
	for m := range dp {
		dp[m] = make([]int, n+1)
		for i := range dp[m] {
			dp[m][i] = math.MaxInt32
		}
	}

	dp[0][0] = 0

	for m := 1; m <= k; m++ {
		for i := 1; i <= n; i++ {
			for p := m - 1; p < i; p++ {
				if dp[m-1][p] != math.MaxInt32 {
					currentCost := dp[m-1][p] + costs[p][i-1]
					if currentCost < dp[m][i] {
						dp[m][i] = currentCost
					}
				}
			}
		}
	}

	return dp[k][n]
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}