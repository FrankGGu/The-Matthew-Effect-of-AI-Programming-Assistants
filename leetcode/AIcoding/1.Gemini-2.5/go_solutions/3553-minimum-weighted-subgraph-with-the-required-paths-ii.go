package main

import (
	"container/heap"
	"math"
)

type edge struct {
	to     int
	weight int
}

type pqItem struct {
	node int
	dist int64
}

type minHeap []pqItem

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *minHeap) Push(x interface{}) {
	*h = append(*h, x.(pqItem))
}
func (h *minHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func dijkstra(n int, adj [][]edge, start int) []int64 {
	dist := make([]int64, n)
	for i := range dist {
		dist[i] = math.MaxInt64
	}
	dist[start] = 0

	pq := &minHeap{}
	heap.Init(pq)
	heap.Push(pq, pqItem{node: start, dist: 0})

	for pq.Len() > 0 {
		item := heap.Pop(pq).(pqItem)
		u := item.node
		d := item.dist

		if d > dist[u] {
			continue
		}

		for _, e := range adj[u] {
			v := e.to
			weight := int64(e.weight)
			if dist[u] != math.MaxInt64 && dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(pq, pqItem{node: v, dist: dist[v]})
			}
		}
	}
	return dist
}

func minimumWeight(n int, edges [][]int, src1 int, src2 int, dest int) int64 {
	adj := make([][]edge, n)
	revAdj := make([][]edge, n)

	for _, e := range edges {
		u, v, w := e[0], e[1], e[2]
		adj[u] = append(adj[u], edge{to: v, weight: w})
		revAdj[v] = append(revAdj[v], edge{to: u, weight: w})
	}

	distFromSrc1 := dijkstra(n, adj, src1)
	distFromSrc2 := dijkstra(n, adj, src2)
	distToDest := dijkstra(n, revAdj, dest)

	minTotalWeight := int64(math.MaxInt64)

	for m := 0; m < n; m++ {
		if distFromSrc1[m] != math.MaxInt64 &&
			distFromSrc2[m] != math.MaxInt64 &&
			distToDest[m] != math.MaxInt64 {

			currentTotalWeight := distFromSrc1[m] + distFromSrc2[m] + distToDest[m]
			if currentTotalWeight < minTotalWeight {
				minTotalWeight = currentTotalWeight
			}
		}
	}

	if minTotalWeight == math.MaxInt64 {
		return -1
	}
	return minTotalWeight
}