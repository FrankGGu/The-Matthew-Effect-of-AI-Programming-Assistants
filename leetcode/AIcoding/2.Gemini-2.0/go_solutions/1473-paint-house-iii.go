import (
	"math"
)

func minCost(houses []int, cost [][]int, m int, n int, target int) int {
	dp := make([][][]int, m+1)
	for i := range dp {
		dp[i] = make([][]int, target+1)
		for j := range dp[i] {
			dp[i][j] = make([]int, n+1)
			for k := range dp[i][j] {
				dp[i][j][k] = -1
			}
		}
	}

	var solve func(int, int, int) int
	solve = func(index int, neighborhoods int, prevColor int) int {
		if index == m {
			if neighborhoods == target {
				return 0
			}
			return math.MaxInt32
		}

		if neighborhoods > target {
			return math.MaxInt32
		}

		if dp[index][neighborhoods][prevColor] != -1 {
			return dp[index][neighborhoods][prevColor]
		}

		res := math.MaxInt32
		if houses[index] != 0 {
			newNeighborhoods := neighborhoods
			if houses[index] != prevColor {
				newNeighborhoods++
			}
			val := solve(index+1, newNeighborhoods, houses[index])
			if val != math.MaxInt32 {
				res = val
			}
		} else {
			for color := 1; color <= n; color++ {
				newNeighborhoods := neighborhoods
				if color != prevColor {
					newNeighborhoods++
				}
				val := solve(index+1, newNeighborhoods, color)
				if val != math.MaxInt32 {
					res = min(res, cost[index][color-1]+val)
				}
			}
		}

		dp[index][neighborhoods][prevColor] = res
		return res
	}

	result := solve(0, 0, 0)
	if result == math.MaxInt32 {
		return -1
	}
	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}