package main

import (
	"container/heap"
)

type State struct {
	x, y, d int
	steps   int
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

func minMovesToReachTarget(grid [][]int) int {
	n := len(grid)
	if grid[0][0] == 1 || grid[n-1][n-1] == 1 {
		return -1
	}

	directions := [4][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	rotations := [4][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}

	visited := make([][][2]bool, n)
	for i := range visited {
		visited[i] = make([][2]bool, n)
	}

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &State{0, 0, 0, 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(*State)
		if curr.x == n-1 && curr.y == n-1 {
			return curr.steps
		}
		if visited[curr.x][curr.y][curr.d] {
			continue
		}
		visited[curr.x][curr.y][curr.d] = true

		for _, dir := range directions {
			newX, newY := curr.x+dir[0], curr.y+dir[1]
			if newX >= 0 && newX < n && newY >= 0 && newY < n && grid[newX][newY] == 0 {
				heap.Push(&pq, &State{newX, newY, curr.d, curr.steps + 1})
			}
		}

		for _, rot := range rotations {
			newX, newY := curr.x+rot[0], curr.y+rot[1]
			if newX >= 0 && newX < n && newY >= 0 && newY < n && grid[newX][newY] == 0 {
				heap.Push(&pq, &State{newX, newY, (curr.d + 1) % 4, curr.steps + 1})
			}
		}
	}

	return -1
}