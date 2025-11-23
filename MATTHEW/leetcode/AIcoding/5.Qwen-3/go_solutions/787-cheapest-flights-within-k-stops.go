package main

import (
	"container/heap"
)

type Edge struct {
	to, cost int
}

type QueueItem struct {
	cost, node, stops int
}

type PriorityQueue []*QueueItem

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*QueueItem))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func findCheapestPrice(n int, flights [][]int, src int, dst int, k int) int {
	graph := make(map[int][]Edge)
	for _, f := range flights {
		graph[f[0]] = append(graph[f[0]], Edge{f[1], f[2]})
	}

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &QueueItem{0, src, k + 1})

	dist := make([]int, n)
	for i := range dist {
		dist[i] = -1
	}
	dist[src] = 0

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*QueueItem)
		cost, node, stops := item.cost, item.node, item.stops

		if node == dst {
			return cost
		}

		if stops == 0 {
			continue
		}

		for _, edge := range graph[node] {
			newCost := cost + edge.cost
			if dist[edge.to] == -1 || newCost < dist[edge.to] {
				dist[edge.to] = newCost
				heap.Push(&pq, &QueueItem{newCost, edge.to, stops - 1})
			}
		}
	}

	return -1
}