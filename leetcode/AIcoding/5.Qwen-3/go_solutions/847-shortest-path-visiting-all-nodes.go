package main

import (
	"container/heap"
)

type State struct {
	node   int
	mask   int
	steps  int
}

type PriorityQueue []*State

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].steps < pq[j].steps
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*State))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func shortestPathLength(grid [][]int) int {
	n := len(grid)
	targetMask := (1 << n) - 1
	visited := make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, 1<<n)
	}
	pq := make(PriorityQueue, 0)
	for i := 0; i < n; i++ {
		mask := 1 << i
		heap.Push(&pq, &State{i, mask, 0})
		visited[i][mask] = true
	}
	for pq.Len() > 0 {
		state := heap.Pop(&pq).(*State)
		if state.mask == targetMask {
			return state.steps
		}
		for _, neighbor := range grid[state.node] {
			newMask := state.mask | (1 << neighbor)
			if !visited[neighbor][newMask] {
				visited[neighbor][newMask] = true
				heap.Push(&pq, &State{neighbor, newMask, state.steps + 1})
			}
		}
	}
	return -1
}