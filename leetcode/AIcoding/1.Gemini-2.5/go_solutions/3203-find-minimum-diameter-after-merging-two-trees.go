package main

import (
	"math"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func bfs(n int, adj [][]int, startNode int) ([]int, int, int) {
	distances := make([]int, n)
	for i := range distances {
		distances[i] = -1
	}

	queue := make([]int, 0, n)
	queue = append(queue, startNode)
	distances[startNode] = 0

	farthestNode := startNode
	maxDist := 0

	head := 0
	for head < len(queue) {
		u := queue[head]
		head++

		if distances[u] > maxDist {
			maxDist = distances[u]
			farthestNode = u
		}

		for _, v := range adj[u] {
			if distances[v] == -1 {
				distances[v] = distances[u] + 1
				queue = append(queue, v)
			}
		}
	}
	return distances, farthestNode, maxDist
}

func solveTree(n int, edges [][]int) (int, int) {
	if n == 0 {
		return 0, 0
	}
	if n == 1 {
		return 0, 0
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	_, u, _ := bfs(n, adj, 0)

	distU, v, diameter := bfs(n, adj, u)

	distV, _, _ := bfs(n, adj, v)

	minEccentricity := math.MaxInt
	for i := 0; i < n; i++ {
		eccentricity := max(distU[i], distV[i])
		minEccentricity = min(minEccentricity, eccentricity)
	}

	return diameter, minEccentricity
}

func getMinDiameterAfterMerge(n1 int, edges1 [][]int, n2 int, edges2 [][]int) int {
	if n1 == 0 && n2 == 0 {
		return 0
	}
	if n1 == 0 {
		D2, _ := solveTree(n2, edges2)
		return D2
	}
	if n2 == 0 {
		D1, _ := solveTree(n1, edges1)
		return D1
	}

	D1, R1 := solveTree(n1, edges1)
	D2, R2 := solveTree(n2, edges2)

	return max(D1, max(D2, R1+1+R2))
}