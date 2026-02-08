package main

import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumWeightedKEdgePath(n int, edges [][]int, k int) int {
	// dp[i][j] stores the maximum weight of a path with exactly 'i' edges ending at node 'j'.
	// Initialize with math.MinInt to represent unreachable states, as weights can be negative.
	dp := make([][]int, k+1)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = math.MinInt
		}
	}

	// Base case: A path of 0 edges has weight 0. It can start and end at any node.
	for i := 0; i < n; i++ {
		dp[0][i] = 0
	}

	// Iterate for path length from 1 to k
	for numEdges := 1; numEdges <= k; numEdges++ {
		// Iterate over all possible edges in the graph
		for _, edge := range edges {
			u, v, weight := edge[0], edge[1], edge[2]

			// If there was a valid path of (numEdges - 1) edges ending at 'u'
			if dp[numEdges-1][u] != math.MinInt {
				// We can extend this path by adding the edge (u -> v)
				// The new path ends at 'v' and has 'numEdges' edges.
				dp[numEdges][v] = max(dp[numEdges][v], dp[numEdges-1][u]+weight)
			}
		}
	}

	// The result is the maximum value among all paths of exactly 'k' edges, ending at any node.
	maxWeight := math.MinInt
	for i := 0; i < n; i++ {
		maxWeight = max(maxWeight, dp[k][i])
	}

	// If no path of 'k' edges was found (maxWeight is still math.MinInt), return -1.
	if maxWeight == math.MinInt {
		return -1
	}

	return maxWeight
}