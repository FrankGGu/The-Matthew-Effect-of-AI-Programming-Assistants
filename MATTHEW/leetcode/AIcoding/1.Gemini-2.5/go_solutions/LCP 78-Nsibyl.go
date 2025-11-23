import (
	"container/heap"
	"math"
)

type Item struct {
	time int
	row  int
	col  int
}

type MinHeap []*Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].time < h[j].time }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	item := x.(*Item)
	*h = append(*h, item)
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func minimumTime(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	// If the start cell is also the target, time is 0.
	if m == 1 && n == 1 {
		return 0
	}

	// Special initial check for being stuck at (0,0).
	// We are at (0,0) at time 0 (since grid[0][0] == 0).
	// To move to an adjacent cell (nr, nc), we arrive at time 1.
	// If grid[nr][nc] > 1, we cannot visit it at time 1.
	// Since grid[0][0] is 0, we cannot "wait" at (0,0) to increase our time;
	// time only increases by moving.
	// Thus, if all possible first moves are blocked (i.e., require time > 1), it's impossible.
	// This check applies only if both neighbors (0,1) and (1,0) exist.
	if m > 1 && n > 1 && grid[0][1] > 1 && grid[1][0] > 1 {
		return -1
	}

	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt64 // Initialize distances with infinity
		}
	}

	dist[0][0] = 0 // Starting time at (0,0) is 0
	pq := &MinHeap{}
	heap.Init(pq)
	heap.Push(pq, &Item{time: 0, row: 0, col: 0})

	// Directions for movement (up, down, left, right)
	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(*Item)
		t, r, c := curr.time, curr.row, curr.col

		// If we found a shorter path to this cell already, skip.
		if t > dist[r][c] {
			continue
		}
		// If we reached the target cell, return its time.
		if r == m-1 && c == n-1 {
			return t
		}

		// Explore neighbors
		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			// Check if neighbor is within grid bounds
			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				arrivalTime := t + 1 // Time when we would arrive at (nr, nc)
				nextTime := arrivalTime

				// If we arrive at (nr, nc) too early (arrivalTime < grid[nr][nc]), we must wait.
				// The time we actually visit is at least grid[nr][nc].
				// However, we can only move in discrete time steps (1 unit per move).
				// If the required waiting time (grid[nr][nc] - arrivalTime) is odd,
				// we must perform an extra round trip (e.g., move to an adjacent cell and back)
				// to increase time by 2, effectively adding 1 unit to the required time.
				if arrivalTime < grid[nr][nc] {
					neededTime := grid[nr][nc]
					timeDiff := neededTime - arrivalTime
					if timeDiff%2 != 0 {
						nextTime = neededTime + 1 // Add 1 for the extra "waiting" step
					} else {
						nextTime = neededTime
					}
				}

				// If this path to (nr, nc) is shorter than previously found, update and push to PQ.
				if nextTime < dist[nr][nc] {
					dist[nr][nc] = nextTime
					heap.Push(pq, &Item{time: nextTime, row: nr, col: nc})
				}
			}
		}
	}

	// If the priority queue becomes empty and target is not reached, it's impossible.
	return -1
}