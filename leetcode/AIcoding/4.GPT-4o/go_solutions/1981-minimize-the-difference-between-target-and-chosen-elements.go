package main

import (
	"sort"
)

func minimizeTheDifference(mat [][]int, target int) int {
	m, n := len(mat), len(mat[0])
	dp := make([]bool, 5001)
	dp[0] = true

	for _, row := range mat {
		nextDp := make([]bool, 5001)
		for _, num := range row {
			for j := 5000 - num; j >= 0; j-- {
				if dp[j] {
					nextDp[j+num] = true
				}
			}
		}
		for j := 0; j <= 5000; j++ {
			if dp[j] || nextDp[j] {
				nextDp[j] = true
			}
		}
		dp = nextDp
	}

	closest := 5000
	for i := 0; i <= 5000; i++ {
		if dp[i] {
			if abs(target-i) < abs(target-closest) {
				closest = i
			}
		}
	}
	return abs(target - closest)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func main() {}