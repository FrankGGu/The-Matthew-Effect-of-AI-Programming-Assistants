package main

import (
	"container/heap"
)

type Point struct {
	row, col int
	time     int
}

type PriorityQueue []*Point

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].time < pq[j].time
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Point))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func minimumTime(grid [][]int) int {
	if grid[0][1] > 1 && grid[1][0] > 1 {
		return -1
	}

	m, n := len(grid), len(grid[0])
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	pq := &PriorityQueue{}
	heap.Push(pq, &Point{0, 0, 0})
	visited[0][0] = true

	directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(*Point)
		if curr.row == m-1 && curr.col == n-1 {
			return curr.time
		}

		for _, dir := range directions {
			r, c := curr.row+dir[0], curr.col+dir[1]
			if r >= 0 && r < m && c >= 0 && c < n && !visited[r][c] {
				nextTime := curr.time + 1
				if grid[r][c] > nextTime {
					nextTime = grid[r][c]
				}
				heap.Push(pq, &Point{r, c, nextTime})
				visited[r][c] = true
			}
		}
	}

	return -1
}