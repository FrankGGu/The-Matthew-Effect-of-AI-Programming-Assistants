package main

import (
	"container/heap"
	"math"
)

type Pair struct {
	node   int
	weight int64
}

type PriorityQueue []Pair

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq Priority) Less(i, j int) bool {
	return pq[i].weight < pq[j].weight
}
func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}
func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Pair)
	*pq = append(*pq, item)
}
func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

const INF int64 = math.MaxInt64 / 2 // Use a large enough number, not MaxInt64 directly to avoid overflow when adding

func dijkstra(n int, start int, graph [][]Pair, dist []int64) {
	for i := 0; i < n; i++ {
		dist[i] = INF
	}
	dist[start] = 0

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, Pair{node: start, weight: 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(Pair)
		u := curr.node
		d := curr.weight

		if d > dist[u] {
			continue
		}

		for _, edge := range graph[u] {
			v := edge.node
			weight := edge.weight
			if dist[u] != INF && dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(&pq, Pair{node: v, weight: dist[v]})
			}
		}
	}
}

func minimumWeight(n int, edges [][]int, source1 int, source2 int, dest int) int64 {
	adj := make([][]Pair, n)
	revAdj := make([][]Pair, n)

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Pair{node: v, weight: int64(w)})
		revAdj[v] = append(revAdj[v], Pair{node: u, weight: int64(w)})
	}

	dist1 := make([]int64, n)
	dist2 := make([]int64, n)
	dist3 := make([]int64, n)

	dijkstra(n, source1, adj, dist1)
	dijkstra(n, source2, adj, dist2)
	dijkstra(n, dest, revAdj, dist3)

	var minTotal int64 = INF
	for i := 0; i < n; i++ {
		if dist1[i] != INF && dist2[i] != INF && dist3[i] != INF {
			currentSum := dist1[i] + dist2[i] + dist3[i]
			if currentSum < minTotal {
				minTotal = currentSum
			}
		}
	}

	if minTotal == INF {
		return -1
	}
	return minTotal
}