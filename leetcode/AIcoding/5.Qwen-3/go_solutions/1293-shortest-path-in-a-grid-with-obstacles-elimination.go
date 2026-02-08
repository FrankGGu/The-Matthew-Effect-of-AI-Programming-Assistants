package main

import (
	"container/heap"
)

type Point struct {
	row, col int
}

type State struct {
	point  Point
	rem    int
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
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func shortestPathGrid(grid [][]int, k int) int {
	m, n := len(grid), len(grid[0])
	visited := make([][]int, m)
	for i := range visited {
		visited[i] = make([]int, n)
		for j := range visited[i] {
			visited[i][j] = -1
		}
	}

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &State{Point{0, 0}, k, 0})
	visited[0][0] = k

	directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

	for pq.Len() > 0 {
		state := heap.Pop(&pq).(*State)
		if state.point.row == m-1 && state.point.col == n-1 {
			return state.steps
		}

		for _, dir := range directions {
			newRow, newCol := state.point.row+dir[0], state.point.col+dir[1]
			if newRow >= 0 && newRow < m && newCol >= 0 && newCol < n {
				newRem := state.rem
				if grid[newRow][newCol] == 1 {
					newRem--
				}
				if newRem >= 0 && (visited[newRow][newCol] < newRem) {
					visited[newRow][newCol] = newRem
					heap.Push(&pq, &State{Point{newRow, newCol}, newRem, state.steps + 1})
				}
			}
		}
	}

	return -1
}