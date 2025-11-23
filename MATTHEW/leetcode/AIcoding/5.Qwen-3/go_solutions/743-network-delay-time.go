package main

import (
	"container/heap"
	"math"
)

type Edge struct {
	node int
	time int
}

type Graph map[int][]Edge

type PriorityQueue []*Edge

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].time < pq[j].time
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
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func networkDelayTime(times [][]int, n int, k int) int {
	graph := make(Graph)
	for _, time := range times {
		src, dest, t := time[0], time[1], time[2]
		graph[src] = append(graph[src], Edge{dest, t})
	}

	dist := make([]int, n+1)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[k] = 0

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &Edge{k, 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(*Edge)
		if curr.time > dist[curr.node] {
			continue
		}
		for _, edge := range graph[curr.node] {
			newTime := curr.time + edge.time
			if newTime < dist[edge.node] {
				dist[edge.node] = newTime
				heap.Push(&pq, &Edge{edge.node, newTime})
			}
		}
	}

	maxTime := 0
	for i := 1; i <= n; i++ {
		if dist[i] == math.MaxInt32 {
			return -1
		}
		if dist[i] > maxTime {
			maxTime = dist[i]
		}
	}
	return maxTime
}