import (
	"container/heap"
	"math"
)

type State struct {
	Elevation int
	R         int
	C         int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Elevation < pq[j].Elevation
}
func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(State)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func swimInRisingWater(grid [][]int) int {
	n := len(grid)

	dist := make([][]int, n)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32
		}
	}

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)

	dist[0][0] = grid[0][0]
	heap.Push(&pq, State{Elevation: grid[0][0], R: 0, C: 0})

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(State)

		currentMaxElevation := curr.Elevation
		r := curr.R
		c := curr.C

		if r == n-1 && c == n-1 {
			return currentMaxElevation
		}

		if currentMaxElevation > dist[r][c] {
			continue
		}

		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < n && nc >= 0 && nc < n {
				newMaxElevation := max(currentMaxElevation, grid[nr][nc])

				if newMaxElevation < dist[nr][nc] {
					dist[nr][nc] = newMaxElevation
					heap.Push(&pq, State{Elevation: newMaxElevation, R: nr, C: nc})
				}
			}
		}
	}

	return -1
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}