package main

import (
	"container/heap"
	"math"
)

type State struct {
	effort int
	r      int
	c      int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].effort < pq[j].effort
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(State)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minimumEffortPath(heights [][]int) int {
	rows := len(heights)
	cols := len(heights[0])

	minEffort := make([][]int, rows)
	for i := range minEffort {
		minEffort[i] = make([]int, cols)
		for j := range minEffort[i] {
			minEffort[i][j] = math.MaxInt32
		}
	}

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	minEffort[0][0] = 0
	pq := make(PriorityQueue, 0)
	heap.Push(&pq, State{effort: 0, r: 0, c: 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(State)
		currentEffort := curr.effort
		r := curr.r
		c := curr.c

		if currentEffort > minEffort[r][c] {
			continue
		}

		if r == rows-1 && c == cols-1 {
			return currentEffort
		}

		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
				diff := abs(heights[r][c] - heights[nr][nc])
				newEffort := max(currentEffort, diff)

				if newEffort < minEffort[nr][nc] {
					minEffort[nr][nc] = newEffort
					heap.Push(&pq, State{effort: newEffort, r: nr, c: nc})
				}
			}
		}
	}

	return minEffort[rows-1][cols-1]
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}