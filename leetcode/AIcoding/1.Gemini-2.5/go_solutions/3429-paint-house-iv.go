package main

import "math"

const INF = math.MaxInt32 / 2 // Use a large enough value for infinity, avoid overflow on addition

func minCost(houses []int, cost [][]int, m int, n int, target int) int {
	// dp[i][j][k] = minimum cost to paint the first i houses (0 to i),
	// with house i painted color j, and forming k neighborhoods.
	// i: house index (0 to m-1)
	// j: color index (0 to n-1, representing colors 1 to n)
	// k: number of neighborhoods (1 to target)

	// dp table dimensions: m x n x (target + 1)
	dp := make([][][]int, m)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, target+1)
			for k := range dp[i][j] {
				dp[i][j][k] = INF
			}
		}
	}

	// Base case: first house (index 0)
	for j := 0; j < n; j++ { // Try painting house 0 with color j+1
		if houses[0] == 0 { // House 0 is unpainted
			dp[0][j][1] = cost[0][j]
		} else if houses[0] == j+1 { // House 0 is already painted with color j+1
			dp[0][j][1] = 0
		}
		// If houses[0] is painted a different color, dp[0][j][1] remains INF, meaning impossible
	}

	// Fill dp table for houses from index 1 to m-1
	for i := 1; i < m; i++ {
		// Precompute the two smallest costs and their indices for dp[i-1][...][k_prev] for all k_prev
		// This optimization reduces the inner loop from O(N) to O(1).
		prevMin1 := make([]int, target+1) // Smallest cost for k_prev neighborhoods at house i-1
		prevIdx1 := make([]int, target+1) // Index of prevMin1
		prevMin2 := make([]int, target+1) // Second smallest cost for k_prev neighborhoods at house i-1
		prevIdx2 := make([]int, target+1) // Index of prevMin2

		for pk := 1; pk <= target; pk++ { // pk is k_prev
			prevMin1[pk] = INF
			prevMin2[pk] = INF
			prevIdx1[pk] = -1
			prevIdx2[pk] = -1

			for pj := 0; pj < n; pj++ { // pj is prevJ (color of house i-1)
				costVal := dp[i-1][pj][pk]
				if costVal < prevMin1[pk] {
					prevMin2[pk] = prevMin1[pk]
					prevIdx2[pk] = prevIdx1[pk]
					prevMin1[pk] = costVal
					prevIdx1[pk] = pj
				} else if costVal < prevMin2[pk] {
					prevMin2[pk] = costVal
					prevIdx2[pk] = pj
				}
			}
		}

		// Now, compute dp[i][j][k]
		for k := 1; k <= target; k++ { // k is current number of neighborhoods
			for j := 0; j < n; j++ { // j is current color for house i
				currentHouseColor := houses[i]
				currentPaintCost := 0

				// If house i is already painted and not with color j+1, this state is impossible
				if currentHouseColor != 0 && currentHouseColor != j+1 {
					continue // dp[i][j][k] remains INF
				}
				// If house i is unpainted, add its painting cost
				if currentHouseColor == 0 {
					currentPaintCost = cost[i][j]
				}

				// Case 1: House i is painted with the same color as house i-1 (j == prevJ)
				// Number of neighborhoods remains k.
				// We need the cost from dp[i-1][j][k].
				if dp[i-1][j][k] != INF {
					dp[i][j][k] = min(dp[i][j][k], dp[i-1][j][k]+currentPaintCost)
				}

				// Case 2: House i is painted with a different color than house i-1 (j != prevJ)
				// Number of neighborhoods increases from k-1 to k.
				// We need the minimum cost from dp[i-1][prevJ][k-1] where prevJ != j.
				if k > 1 { // Only possible if we can form k-1 neighborhoods previously
					// Use precomputed min1/min2 for k-1 neighborhoods from previous row (i-1)
					if prevIdx1[k-1] != j { // If the best previous color is not current j
						if prevMin1[k-1] != INF {
							dp[i][j][k] = min(dp[i][j][k], prevMin1[k-1]+currentPaintCost)
						}
					} else { // If the best previous color IS current j, use the second best
						if prevMin2[k-1] != INF {
							dp[i][j][k] = min(dp[i][j][k], prevMin2[k-1]+currentPaintCost)
						}
					}
				}
			}
		}
	}

	// Find the overall minimum cost from the last row for target neighborhoods
	minTotalCost := INF
	for j := 0; j < n; j++ {
		minTotalCost = min(minTotalCost, dp[m-1][j][target])
	}

	if minTotalCost == INF {
		return -1 // No valid way to paint houses to achieve target neighborhoods
	}
	return minTotalCost
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}