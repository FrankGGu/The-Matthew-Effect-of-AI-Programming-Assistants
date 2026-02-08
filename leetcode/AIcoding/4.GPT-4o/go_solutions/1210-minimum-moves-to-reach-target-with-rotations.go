package main

import (
	"container/heap"
)

type Status struct {
	x, y, moves int
}

type PriorityQueue []Status

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].moves < pq[j].moves }
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(Status))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func minMoves(target []int) int {
	tX, tY := target[0], target[1]
	if tX == 0 && tY == 0 {
		return 0
	}

	pq := &PriorityQueue{{0, 0, 0}}
	heap.Init(pq)
	visited := make(map[[2]int]bool)
	visited[[2]int{0, 0}] = true

	for pq.Len() > 0 {
		status := heap.Pop(pq).(Status)

		if status.x == tX && status.y == tY {
			return status.moves
		}

		nextMoves := [][2]int{
			{status.x + 1, status.y}, {status.x, status.y + 1},
			{status.x - 1, status.y}, {status.x, status.y - 1},
			{status.y, status.x}, {-status.y, status.x},
			{status.y, -status.x}, {-status.y, -status.x},
		}

		for _, next := range nextMoves {
			if !visited[[2]int{next[0], next[1]}] && abs(next[0]) <= abs(tX)+1 && abs(next[1]) <= abs(tY)+1 {
				visited[[2]int{next[0], next[1]}] = true
				heap.Push(pq, Status{next[0], next[1], status.moves + 1})
			}
		}
	}
	return -1
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func minimumMoves(target []int) int {
	return minMoves(target)
}