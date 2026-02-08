package main

import (
	"container/heap"
	"fmt"
)

type State struct {
	board string
	zero  int
	step  int
}

type Item struct {
	state State
	priority int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].priority < pq[j].priority }
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func slidingPuzzle(board [][]int) int {
	start := ""
	for _, row := range board {
		for _, num := range row {
			start += fmt.Sprint(num)
		}
	}
	target := "123450"
	if start == target {
		return 0
	}

	zeroIndex := startFindZero(start)
	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{State{start, zeroIndex, 0}, h(start)})

	visited := map[string]bool{start: true}
	directions := []int{-1, 1, -3, 3}

	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		state := item.state

		for _, d := range directions {
			newZero := state.zero + d
			if newZero < 0 || newZero >= 6 || (state.zero%3 == 0 && d == -1) || (state.zero%3 == 2 && d == 1) {
				continue
			}
			newBoard := swap(state.board, state.zero, newZero)
			if newBoard == target {
				return state.step + 1
			}
			if !visited[newBoard] {
				visited[newBoard] = true
				heap.Push(pq, &Item{State{newBoard, newZero, state.step + 1}, h(newBoard) + state.step + 1})
			}
		}
	}
	return -1
}

func startFindZero(board string) int {
	for i, c := range board {
		if c == '0' {
			return i
		}
	}
	return -1
}

func swap(board string, i, j int) string {
	b := []byte(board)
	b[i], b[j] = b[j], b[i]
	return string(b)
}

func h(board string) int {
	target := "123450"
	count := 0
	for i, c := range board {
		if c != target[i] && c != '0' {
			count++
		}
	}
	return count
}