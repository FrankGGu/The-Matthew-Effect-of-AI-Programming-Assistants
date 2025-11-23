package main

import (
	"container/heap"
)

type State struct {
	board   []int
	blank   int
	steps   int
	heapIdx int
}

type PriorityQueue []*State

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].steps < pq[j].steps
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].heapIdx = i
	pq[j].heapIdx = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	item := x.(*State)
	item.heapIdx = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil
	item.heapIdx = -1
	*pq = old[0 : n-1]
	return item
}

func slidingPuzzle(board [][]int) int {
	start := make([]int, 6)
	for i := 0; i < 2; i++ {
		for j := 0; j < 3; j++ {
			start[i*3+j] = board[i][j]
		}
	}

	target := []int{1, 2, 3, 4, 5, 0}

	neighbors := [][]int{
		{1, 3},
		{0, 2, 4},
		{1, 5},
		{0, 4},
		{1, 3, 5},
		{2, 4},
	}

	visited := make(map[string]bool)
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)

	initialState := &State{
		board: start,
		blank: findBlank(start),
		steps: 0,
	}
	heap.Push(&pq, initialState)

	for pq.Len() > 0 {
		current := heap.Pop(&pq).(*State)
		currentBoard := current.board
		currentBlank := current.blank

		if isTarget(currentBoard, target) {
			return current.steps
		}

		key := boardToString(currentBoard)
		if visited[key] {
			continue
		}
		visited[key] = true

		for _, neighbor := range neighbors[currentBlank] {
			newBoard := make([]int, 6)
			copy(newBoard, currentBoard)
			newBoard[currentBlank], newBoard[neighbor] = newBoard[neighbor], newBoard[currentBlank]
			newState := &State{
				board:   newBoard,
				blank:   neighbor,
				steps:   current.steps + 1,
				heapIdx: -1,
			}
			heap.Push(&pq, newState)
		}
	}

	return -1
}

func findBlank(board []int) int {
	for i, val := range board {
		if val == 0 {
			return i
		}
	}
	return -1
}

func isTarget(board, target []int) bool {
	for i := 0; i < 6; i++ {
		if board[i] != target[i] {
			return false
		}
	}
	return true
}

func boardToString(board []int) string {
	s := ""
	for _, val := range board {
		s += strconv.Itoa(val)
	}
	return s
}