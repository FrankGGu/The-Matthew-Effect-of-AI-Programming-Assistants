package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	to, weight int
}

type PriorityQueue [][2]int

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i][1] < pq[j][1] }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }
func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.([2]int))
}
func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[:n-1]
	return x
}

func dijkstra(n int, adj [][]Edge, start int) []int {
	dist := make([]int, n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[start] = 0
	pq := PriorityQueue{[2]int{start, 0}}
	heap.Init(&pq)

	for pq.Len() > 0 {
		node := heap.Pop(&pq).([2]int)
		u, d := node[0], node[1]
		if d > dist[u] {
			continue
		}
		for _, edge := range adj[u] {
			v, w := edge.to, edge.weight
			if dist[v] > dist[u]+w {
				dist[v] = dist[u] + w
				heap.Push(&pq, [2]int{v, dist[v]})
			}
		}
	}
	return dist
}

func minimumWeight(n int, edges [][]int, src1 int, src2 int, dest int) int64 {
	adj := make([][]Edge, n)
	revAdj := make([][]Edge, n)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{v, w})
		revAdj[v] = append(revAdj[v], Edge{u, w})
	}

	distSrc1 := dijkstra(n, adj, src1)
	distSrc2 := dijkstra(n, adj, src2)
	distDest := dijkstra(n, revAdj, dest)

	minWeight := int64(math.MaxInt64)
	for i := 0; i < n; i++ {
		if distSrc1[i] == math.MaxInt32 || distSrc2[i] == math.MaxInt32 || distDest[i] == math.MaxInt32 {
			continue
		}
		total := int64(distSrc1[i] + distSrc2[i] + distDest[i])
		if total < minWeight {
			minWeight = total
		}
	}

	if minWeight == math.MaxInt64 {
		return -1
	}
	return minWeight
}