package main

import (
	"container/heap"
)

type Edge struct {
	to, weight int
}

type PriorityQueue []*Edge

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].weight < pq[j].weight
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Edge))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minWeightedSubgraphToCoverPaths(n int, edges [][]int, paths [][]int) int {
	graph := make(map[int][]Edge)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		graph[u] = append(graph[u], Edge{v, w})
		graph[v] = append(graph[v], Edge{u, w})
	}

	type State struct {
		node, dist int
	}

	dijkstra := func(start int) map[int]int {
		dist := make(map[int]int)
		for i := 1; i <= n; i++ {
			dist[i] = int(1e9)
		}
		dist[start] = 0
		pq := make(PriorityQueue, 0)
		heap.Push(&pq, &Edge{start, 0})
		for pq.Len() > 0 {
			curr := heap.Pop(&pq).(*Edge)
			if curr.weight > dist[curr.to] {
				continue
			}
			for _, e := range graph[curr.to] {
				if dist[e.to] > dist[curr.to]+e.weight {
					dist[e.to] = dist[curr.to] + e.weight
					heap.Push(&pq, &Edge{e.to, dist[e.to]})
				}
			}
		}
		return dist
	}

	result := 0
	for _, path := range paths {
		src, dest := path[0], path[1]
		dist := dijkstra(src)
		result += dist[dest]
	}

	return result
}