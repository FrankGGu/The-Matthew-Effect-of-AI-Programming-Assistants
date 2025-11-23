package main

import (
	"container/heap"
	"math"
)

const MOD = 1e9 + 7

type Item struct {
	time int64
	node int
}

type PriorityQueue []Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].time < pq[j].time
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func countPaths(n int, roads [][]int) int {
	adj := make([][][]int, n)
	for _, road := range roads {
		u, v, t := road[0], road[1], road[2]
		adj[u] = append(adj[u], []int{v, t})
		adj[v] = append(adj[v], []int{u, t})
	}

	dist := make([]int64, n)
	ways := make([]int64, n)
	for i := 0; i < n; i++ {
		dist[i] = math.MaxInt64
	}

	dist[0] = 0
	ways[0] = 1

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, Item{time: 0, node: 0})

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(Item)
		d := item.time
		u := item.node

		if d > dist[u] {
			continue
		}

		for _, edge := range adj[u] {
			v := edge[0]
			t := int64(edge[1])

			newDist := d + t

			if newDist < dist[v] {
				dist[v] = newDist
				ways[v] = ways[u]
				heap.Push(&pq, Item{time: newDist, node: v})
			} else if newDist == dist[v] {
				ways[v] = (ways[v] + ways[u]) % MOD
			}
		}
	}

	return int(ways[n-1])
}