package main

import (
	"container/heap"
)

type Edge struct {
	row, col, cost int
}

type PriorityQueue []*Edge

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Edge))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func findMinimumEffortPath(rooms [][]int) int {
	m, n := len(rooms), len(rooms[0])
	efforts := make([][]int, m)
	for i := range efforts {
		efforts[i] = make([]int, n)
		for j := range efforts[i] {
			efforts[i][j] = 1<<31 - 1
		}
	}
	efforts[0][0] = 0
	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &Edge{0, 0, 0})
	directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(*Edge)
		if curr.row == m-1 && curr.col == n-1 {
			return curr.cost
		}
		for _, dir := range directions {
			newRow, newCol := curr.row+dir[0], curr.col+dir[1]
			if newRow >= 0 && newRow < m && newCol >= 0 && newCol < n {
				newCost := max(curr.cost, abs(rooms[newRow][newCol]-rooms[curr.row][curr.col]))
				if newCost < efforts[newRow][newCol] {
					efforts[newRow][newCol] = newCost
					heap.Push(&pq, &Edge{newRow, newCol, newCost})
				}
			}
		}
	}
	return 0
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}