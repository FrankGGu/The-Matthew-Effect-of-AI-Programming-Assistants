package main

import (
	"container/heap"
)

type Point struct {
	x, y int
}

type MinHeap []Point

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return i < j }
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

func highestPeak(isWater [][]int) [][]int {
	m, n := len(isWater), len(isWater[0])
	heights := make([][]int, m)
	for i := range heights {
		heights[i] = make([]int, n)
		for j := range heights[i] {
			heights[i][j] = -1
		}
	}

	h := &MinHeap{}
	heap.Init(h)
	directions := [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if isWater[i][j] == 1 {
				heights[i][j] = 0
				heap.Push(h, Point{i, j})
			}
		}
	}

	for h.Len() > 0 {
		p := heap.Pop(h).(Point)
		for _, d := range directions {
			x, y := p.x+d[0], p.y+d[1]
			if x >= 0 && x < m && y >= 0 && y < n && heights[x][y] == -1 {
				heights[x][y] = heights[p.x][p.y] + 1
				heap.Push(h, Point{x, y})
			}
		}
	}

	return heights
}