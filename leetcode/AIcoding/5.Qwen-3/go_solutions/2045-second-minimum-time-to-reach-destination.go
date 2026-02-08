package main

import (
	"container/heap"
)

type Edge struct {
	to, time int
}

type MinHeap [][]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][1] < h[j][1] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func secondMinimum(n int, edges [][]int, time int, restricted []int) int {
	graph := make([][]Edge, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], Edge{v, time})
		graph[v] = append(graph[v], Edge{u, time})
	}

	restrictedSet := make(map[int]bool)
	for _, r := range restricted {
		restrictedSet[r] = true
	}

	dist := make([][]int, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int, 2)
		for j := 0; j < 2; j++ {
			dist[i][j] = -1
		}
	}

	h := &MinHeap{}
	heap.Init(h)
	heap.Push(h, []int{0, 0})
	dist[0][0] = 0

	for h.Len() > 0 {
		curr := heap.Pop(h).([]int)
		node, currTime := curr[0], curr[1]

		if node == n-1 {
			if dist[n-1][1] != -1 {
				return dist[n-1][1]
			}
			continue
		}

		if restrictedSet[node] {
			continue
		}

		for _, edge := range graph[node] {
			nextNode, nextTime := edge.to, currTime+edge.time

			if dist[nextNode][0] == -1 || nextTime < dist[nextNode][0] {
				if dist[nextNode][0] != -1 && nextTime == dist[nextNode][0] {
					continue
				}
				dist[nextNode][1] = dist[nextNode][0]
				dist[nextNode][0] = nextTime
				heap.Push(h, []int{nextNode, nextTime})
			} else if dist[nextNode][1] == -1 || nextTime < dist[nextNode][1] {
				dist[nextNode][1] = nextTime
				heap.Push(h, []int{nextNode, nextTime})
			}
		}
	}

	if dist[n-1][1] == -1 {
		return -1
	}
	return dist[n-1][1]
}