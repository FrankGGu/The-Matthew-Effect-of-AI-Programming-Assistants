package main

import "math"

func shortestCycle(n int, edges [][]int) int {
	graph := make([][]int, n)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], edge[1])
		graph[edge[1]] = append(graph[edge[1]], edge[0])
	}

	shortest := math.MaxInt32

	for start := 0; start < n; start++ {
		queue := []int{start}
		dist := make([]int, n)
		for i := range dist {
			dist[i] = -1
		}
		dist[start] = 0

		for len(queue) > 0 {
			node := queue[0]
			queue = queue[1:]

			for _, neighbor := range graph[node] {
				if dist[neighbor] == -1 {
					dist[neighbor] = dist[node] + 1
					queue = append(queue, neighbor)
				} else if neighbor != start {
					shortest = min(shortest, dist[node]+dist[neighbor]+1)
				}
			}
		}
	}

	if shortest == math.MaxInt32 {
		return -1
	}
	return shortest
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}