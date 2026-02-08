import (
	"container/heap"
	"math"
)

type State struct {
	Time int // Total time elapsed to reach this state
	R    int // Row coordinate
	C    int // Column coordinate
	K    int // Remaining free passes
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Time < pq[j].Time
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

func findMinimumTime(grid [][]int, k int) int {
	rows := len(grid)
	cols := len(grid[0])

	// minTime[r][c][k_rem] stores the minimum time to reach (r, c) with k_rem free passes remaining.
	// Initialize with infinity.
	minTime := make([][][]int, rows)
	for r := 0; r < rows; r++ {
		minTime[r] = make([][]int, cols)
		for c := 0; c < cols; c++ {
			minTime[r][c] = make([]int, k+1)
			for i := 0; i <= k; i++ {
				minTime[r][c][i] = math.MaxInt32
			}
		}
	}

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)

	// Initialize the starting cell (0,0).
	cost00 := grid[0][0]

	// Option 1: Pay the cost for grid[0][0].
	if minTime[0][0][k] > cost00 {
		minTime[0][0][k] = cost00
		heap.Push(&pq, State{Time: cost00, R: 0, C: 0, K: k})
	}

	// Option 2: Use a free pass for grid[0][0] if k > 0 and cost00 > 0.
	// If cost00 is 0, no pass is needed or used.
	if k > 0 && cost00 > 0 {
		if minTime[0][0][k-1] > 0 { // Cost becomes 0
			minTime[0][0][k-1] = 0
			heap.Push(&pq, State{Time: 0, R: 0, C: 0, K: k - 1})
		}
	}

	// Directions for movement: up, down, left, right
	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(State)

		// If we found a shorter path to this state already, skip.
		if curr.Time > minTime[curr.R][curr.C][curr.K] {
			continue
		}

		// If we reached the target, this is the minimum time.
		if curr.R == rows-1 && curr.C == cols-1 {
			return curr.Time
		}

		// Explore neighbors
		for i := 0; i < 4; i++ {
			nr, nc := curr.R+dr[i], curr.C+dc[i]

			// Check if the neighbor is within grid boundaries
			if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
				nextCost := grid[nr][nc]

				// Option 1: Pay the cost for (nr, nc)
				newTime := curr.Time + nextCost
				if newTime < minTime[nr][nc][curr.K] {
					minTime[nr][nc][curr.K] = newTime
					heap.Push(&pq, State{Time: newTime, R: nr, C: nc, K: curr.K})
				}

				// Option 2: Use a free pass for (nr, nc) (if available and cost > 0)
				if curr.K > 0 && nextCost > 0 {
					newTimeWithFreePass := curr.Time // Cost for this step is 0
					if newTimeWithFreePass < minTime[nr][nc][curr.K-1] {
						minTime[nr][nc][curr.K-1] = newTimeWithFreePass
						heap.Push(&pq, State{Time: newTimeWithFreePass, R: nr, C: nc, K: curr.K - 1})
					}
				}
			}
		}
	}

	// If the target is unreachable
	return -1
}