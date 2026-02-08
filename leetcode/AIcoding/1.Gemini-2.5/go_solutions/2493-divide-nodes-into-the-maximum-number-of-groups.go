package main

import (
	"container/list"
)

func maximumGroups(n int, edges [][]int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	visited := make([]bool, n)
	level := make([]int, n) // Stores level/distance from source in its component
	for i := range level {
		level[i] = -1 // -1 means unvisited
	}

	maxOverallDepth := 0

	for i := 0; i < n; i++ {
		if !visited[i] {
			q := list.New()
			q.PushBack(i)
			visited[i] = true
			level[i] = 0
			currentCompMaxDepth := 0

			for q.Len() > 0 {
				e := q.Front()
				q.Remove(e)
				u := e.Value.(int)

				if level[u] > currentCompMaxDepth {
					currentCompMaxDepth = level[u]
				}

				for _, v := range adj[u] {
					if !visited[v] {
						visited[v] = true
						level[v] = level[u] + 1
						q.PushBack(v)
					} else {
						// v is visited. Check consistency.
						// For an edge (u, v), |level[u] - level[v]| must be 1.
						// If it's not 1, it means an odd cycle or inconsistent levels, making it impossible.
						if abs(level[u]-level[v]) != 1 {
							return 0 // Impossible to satisfy conditions
						}
					}
				}
			}
			if currentCompMaxDepth > maxOverallDepth {
				maxOverallDepth = currentCompMaxDepth
			}
		}
	}

	return maxOverallDepth + 1
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}