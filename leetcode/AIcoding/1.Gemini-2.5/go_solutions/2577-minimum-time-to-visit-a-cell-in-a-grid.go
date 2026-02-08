import (
	"container/heap"
	"math"
)

type Item struct {
	time int
	r, c int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].time < pq[j].time
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minimumTime(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	// If starting and ending cell are the same, time is 0.
	if m == 1 && n == 1 {
		return 0
	}

	// Special condition as per problem description note:
	// "If grid[0][1] and grid[1][0] are both greater than 1, then it is impossible to reach any cell
	// adjacent to (0, 0) at time 1. In this case, you can't even move from (0, 0), so return -1."
	// This check is only valid if both (0,1) and (1,0) exist, meaning m >= 2 and n >= 2.
	if m >= 2 && n >= 2 {
		if grid[0][1] > 1 && grid[1][0] > 1 {
			return -1
		}
	}

	// dist[r][c] stores the minimum time to reach cell (r, c).
	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32 // Initialize with a large value (infinity)
		}
	}

	// Start at (0,0) at time 0.
	dist[0][0] = 0

	// Priority queue to store (time, r, c) tuples, ordered by time.
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, &Item{time: 0, r: 0, c: 0})

	// Directions for moving to adjacent cells (up, down, left, right).
	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		currentTime := item.time
		r, c := item.r, item.c

		// If we reached the target cell, return its time.
		if r == m-1 && c == n-1 {
			return currentTime
		}

		// If we found a shorter path to this cell already, skip.
		if currentTime > dist[r][c] {
			continue
		}

		// Explore neighbors.
		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			// Check if neighbor is within grid boundaries.
			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				// Time taken to travel to the neighbor is 1 unit.
				// So, arrival time at neighbor (before considering grid[nr][nc]) is currentTime + 1.
				timeToArrive := currentTime + 1

				// To enter cell (nr, nc), we must wait until the current time is at least grid[nr][nc].
				// So, the actual time we enter (nr, nc) is max(timeToArrive, grid[nr][nc]).
				newTime := int(math.Max(float64(timeToArrive), float64(grid[nr][nc])))

				// If this path to (nr, nc) is shorter, update dist and push to PQ.
				if newTime < dist[nr][nc] {
					dist[nr][nc] = newTime
					heap.Push(&pq, &Item{time: newTime, r: nr, c: nc})
				}
			}
		}
	}

	// If the target cell (m-1, n-1) was never reached, its distance remains infinity.
	if dist[m-1][n-1] == math.MaxInt32 {
		return -1
	}
	return dist[m-1][n-1]
}