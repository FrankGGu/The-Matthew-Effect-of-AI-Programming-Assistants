package main

import (
	"container/heap"
)

type Pair struct {
	pos  int
	dist int
}

type MinHeap []Pair

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Pair))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func snakesAndLadders(board [][]int) int {
	n := len(board)
	size := n * n
	dest := make([]int, size+1)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if board[i][j] != -1 {
				dest[n*n-(i*n+j)] = board[i][j]
			}
		}
	}

	minHeap := &MinHeap{}
	heap.Init(minHeap)
	heap.Push(minHeap, Pair{1, 0})

	visited := make([]bool, size+1)
	visited[1] = true

	for minHeap.Len() > 0 {
		current := heap.Pop(minHeap).(Pair)

		if current.pos == size {
			return current.dist
		}

		for i := 1; i <= 6; i++ {
			nextPos := current.pos + i
			if nextPos <= size {
				if dest[nextPos] != 0 {
					nextPos = dest[nextPos]
				}
				if !visited[nextPos] {
					visited[nextPos] = true
					heap.Push(minHeap, Pair{nextPos, current.dist + 1})
				}
			}
		}
	}
	return -1
}