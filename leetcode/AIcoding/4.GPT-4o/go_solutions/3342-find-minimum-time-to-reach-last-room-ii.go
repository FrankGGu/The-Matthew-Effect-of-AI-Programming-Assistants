package main

import (
	"container/heap"
)

type Node struct {
	x, y, time int
}

type MinHeap []Node

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].time < h[j].time }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Node))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minimumTime(grid [][]int) int {
	directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	m, n := len(grid), len(grid[0])
	minTime := make([][]int, m)
	for i := range minTime {
		minTime[i] = make([]int, n)
		for j := range minTime[i] {
			minTime[i][j] = int(1e9)
		}
	}
	minTime[0][0] = 0
	h := &MinHeap{}
	heap.Push(h, Node{0, 0, 0})

	for h.Len() > 0 {
		current := heap.Pop(h).(Node)
		x, y, time := current.x, current.y, current.time

		for _, d := range directions {
			nx, ny := x+d[0], y+d[1]
			if nx >= 0 && nx < m && ny >= 0 && ny < n {
				waitTime := 0
				if time%grid[nx][ny] != 0 {
					waitTime = grid[nx][ny] - (time % grid[nx][ny])
				}
				newTime := time + waitTime + 1
				if newTime < minTime[nx][ny] {
					minTime[nx][ny] = newTime
					heap.Push(h, Node{nx, ny, newTime})
				}
			}
		}
	}
	return minTime[m-1][n-1]
}