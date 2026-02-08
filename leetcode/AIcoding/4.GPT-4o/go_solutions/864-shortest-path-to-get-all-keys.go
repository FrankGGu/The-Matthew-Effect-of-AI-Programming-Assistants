package main

import "container/heap"

type State struct {
	x, y, keys int
}

type PriorityQueue []*State

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].keys < pq[j].keys }
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*State))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func shortestPathAllKeys(grid []string) int {
	m, n := len(grid), len(grid[0])
	keyCount := 0
	startX, startY := -1, -1

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == '@' {
				startX, startY = i, j
			} else if grid[i][j] >= 'a' && grid[i][j] <= 'f' {
				keyCount++
			}
		}
	}

	directions := []struct{ dx, dy int }{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	visited := make(map[[3]int]bool)
	pq := &PriorityQueue{}
	heap.Push(pq, &State{startX, startY, 0})
	visited[[3]int{startX, startY, 0}] = true
	steps := 0

	for pq.Len() > 0 {
		for size := pq.Len(); size > 0; size-- {
			state := heap.Pop(pq).(*State)
			if state.keys == (1<<keyCount)-1 {
				return steps
			}
			for _, d := range directions {
				newX, newY := state.x+d.dx, state.y+d.dy
				if newX >= 0 && newX < m && newY >= 0 && newY < n {
					cell := grid[newX][newY]
					if cell == '#' {
						continue
					}
					newKeys := state.keys
					if cell >= 'a' && cell <= 'f' {
						newKeys |= 1 << (cell - 'a')
					} else if cell >= 'A' && cell <= 'F' {
						if state.keys&(1<<(cell-'A')) == 0 {
							continue
						}
					}
					if !visited[[3]int{newX, newY, newKeys}] {
						visited[[3]int{newX, newY, newKeys}] = true
						heap.Push(pq, &State{newX, newY, newKeys})
					}
				}
			}
		}
		steps++
	}
	return -1
}