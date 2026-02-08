package main

import "fmt"

type Edge struct {
	u, v, weight int
}

func maxWeightedKEdgePath(n int, edges [][]int, k int) int {
	graph := make([][]Edge, n)
	for _, edge := range edges {
		u, v, weight := edge[0], edge[1], edge[2]
		graph[u] = append(graph[u], Edge{u, v, weight})
		graph[v] = append(graph[v], Edge{v, u, weight})
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := range dp {
		for j := 0; j <= k; j++ {
			dp[i][j] = -1
		}
	}

	var dfs func(node, parent, depth int) int
	dfs = func(node, parent, depth int) int {
		if depth > k {
			return 0
		}
		maxWeight := 0
		for _, edge := range graph[node] {
			if edge.v != parent {
				nextWeight := dfs(edge.v, node, depth+1)
				if nextWeight != -1 {
					maxWeight = max(maxWeight, edge.weight+nextWeight)
				}
			}
		}
		return maxWeight
	}

	maxPath := 0
	for i := 0; i < n; i++ {
		for j := 0; j <= k; j++ {
			dp[i][j] = dfs(i, -1, 0)
		}
		maxPath = max(maxPath, dp[i][k])
	}

	return maxPath
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {
	n := 5
	edges := [][]int{{0, 1, 3}, {1, 2, 4}, {2, 3, 5}, {3, 4, 2}, {0, 4, 6}}
	k := 2
	fmt.Println(maxWeightedKEdgePath(n, edges, k))
}