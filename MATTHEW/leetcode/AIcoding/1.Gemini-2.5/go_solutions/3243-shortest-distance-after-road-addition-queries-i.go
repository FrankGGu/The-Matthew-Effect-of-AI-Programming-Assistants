package main

import (
	"container/list"
)

func shortestDistanceAfterRoadAdditionQueriesI(n int, initialEdges [][]int, queries [][]int) []int {
	adj := make([][]int, n+1)

	for _, edge := range initialEdges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	results := make([]int, 0, len(queries))

	for _, query := range queries {
		uAdd, vAdd, s, t := query[0], query[1], query[2], query[3]

		adj[uAdd] = append(adj[uAdd], vAdd)
		adj[vAdd] = append(adj[vAdd], uAdd)

		dist := make([]int, n+1)
		for i := 1; i <= n; i++ {
			dist[i] = -1
		}

		q := list.New()

		dist[s] = 0
		q.PushBack(s)

		found := false
		for q.Len() > 0 {
			curr := q.Remove(q.Front()).(int)

			if curr == t {
				found = true
				break
			}

			for _, neighbor := range adj[curr] {
				if dist[neighbor] == -1 {
					dist[neighbor] = dist[curr] + 1
					q.PushBack(neighbor)
				}
			}
		}

		if found {
			results = append(results, dist[t])
		} else {
			results = append(results, -1)
		}
	}

	return results
}