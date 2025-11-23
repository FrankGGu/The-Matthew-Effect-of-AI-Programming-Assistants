package main

import (
	"container/heap"
)

type Point struct {
	x, y int
}

type MinHeap []Point

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].x*h[i].x+h[i].y*h[i].y < h[j].x*h[j].x+h[j].y*h[j].y }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Point))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func canReach(maze [][]int, start []int, destination []int) bool {
	m, n := len(maze), len(maze[0])
	directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
	visited := make(map[[2]int]bool)
	h := &MinHeap{}
	heap.Push(h, Point{start[0], start[1]})

	for h.Len() > 0 {
		point := heap.Pop(h).(Point)
		x, y := point.x, point.y
		if x == destination[0] && y == destination[1] {
			return true
		}
		if visited[[2]int{x, y}] {
			continue
		}
		visited[[2]int{x, y}] = true

		for _, dir := range directions {
			newX, newY := x, y
			for newX+dir[0] >= 0 && newX+dir[0] < m && newY+dir[1] >= 0 && newY+dir[1] < n && maze[newX+dir[0]][newY+dir[1]] == 0 {
				newX += dir[0]
				newY += dir[1]
			}
			if !visited[[2]int{newX, newY}] {
				heap.Push(h, Point{newX, newY})
			}
		}
	}
	return false
}

func main() {}