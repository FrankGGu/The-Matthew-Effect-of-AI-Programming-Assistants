package main

import (
	"math"
	"sort"
)

func maxStarSum(vals []int, edges [][]int, k int) int {
	n := len(vals)

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	maxSum := math.MinInt32

	for i := 0; i < n; i++ {
		currentStarSum := vals[i]

		if k == 0 {
			if currentStarSum > maxSum {
				maxSum = currentStarSum
			}
			continue
		}

		neighborValues := []int{}
		for _, neighborIdx := range adj[i] {
			neighborValues = append(neighborValues, vals[neighborIdx])
		}

		sort.Slice(neighborValues, func(a, b int) bool {
			return neighborValues[a] > neighborValues[b]
		})

		numNeighborsToTake := k
		if len(neighborValues) < k {
			numNeighborsToTake = len(neighborValues)
		}

		for j := 0; j < numNeighborsToTake; j++ {
			currentStarSum += neighborValues[j]
		}

		if currentStarSum > maxSum {
			maxSum = currentStarSum
		}
	}

	return maxSum
}