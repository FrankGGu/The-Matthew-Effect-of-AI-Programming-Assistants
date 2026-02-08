package main

import (
	"container/heap"
	"math"
)

type Tree struct {
	height int
	x      int
	y      int
}

type MinHeap []Tree

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].height < h[j].height }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Tree))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func cutOffTree(forest [][]int) int {
	if len(forest) == 0 || len(forest[0]) == 0 {
		return 0
	}
	m, n := len(forest), len(forest[0])
	var trees MinHeap

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if forest[i][j] > 1 {
				heap.Push(&trees, Tree{height: forest[i][j], x: i, y: j})
			}
		}
	}

	startX, startY := 0, 0
	totalSteps := 0

	for trees.Len() > 0 {
		tree := heap.Pop(&trees).(Tree)
		steps := bfs(forest, startX, startY, tree.x, tree.y)
		if steps == -1 {
			return -1
		}
		totalSteps += steps
		startX, startY = tree.x, tree.y
	}

	return totalSteps
}

func bfs(forest [][]int, startX, startY, targetX, targetY int) int {
	m, n := len(forest), len(forest[0])
	directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	queue := [][]int{{startX, startY}}
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}
	visited[startX][startY] = true
	steps := 0

	for len(queue) > 0 {
		steps++
		for size := len(queue); size > 0; size-- {
			curr := queue[0]
			queue = queue[1:]
			x, y := curr[0], curr[1]

			if x == targetX && y == targetY {
				return steps - 1
			}

			for _, d := range directions {
				newX, newY := x+d[0], y+d[1]
				if newX >= 0 && newX < m && newY >= 0 && newY < n && forest[newX][newY] != 0 && !visited[newX][newY] {
					visited[newX][newY] = true
					queue = append(queue, []int{newX, newY})
				}
			}
		}
	}

	return -1
}

func main() {
	// You can test the function here.
}