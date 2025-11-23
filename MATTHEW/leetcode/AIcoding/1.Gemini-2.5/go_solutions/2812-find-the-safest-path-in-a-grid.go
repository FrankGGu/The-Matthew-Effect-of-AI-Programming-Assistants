package main

import (
	"container/list"
	"math"
)

func maximumSafenessFactor(grid [][]int) int {
	n := len(grid)

	// Step 1: Calculate safeness factor for all cells using multi-source BFS
	// dist[r][c] will store the Manhattan distance from (r,c) to the nearest thief.
	dist := make([][]int, n)
	q := list.New() // Queue for BFS

	// Directions for BFS (up, down, left, right)
	dirs := []struct{ r, c int }{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

	for r := 0; r < n; r++ {
		dist[r] = make([]int, n)
		for c := 0; c < n; c++ {
			if grid[r][c] == 1 {
				dist[r][c] = 0           // Thief cell has safeness factor 0
				q.PushBack([2]int{r, c}) // Add all thief locations to the queue
			} else {
				dist[r][c] = math.MaxInt32 // Initialize non-thief cells with a large value (infinity)
			}
		}
	}

	// Perform BFS to calculate distances from all thieves
	for q.Len() > 0 {
		curr := q.Remove(q.Front()).([2]int)
		r, c := curr[0], curr[1]

		for _, dir := range dirs {
			nr, nc := r+dir.r, c+dir.c
			// Check bounds and if the neighbor has not been visited yet (i.e., its distance is still infinity)
			if nr >= 0 && nr < n && nc >= 0 && nc < n && dist[nr][nc] == math.MaxInt32 {
				dist[nr][nc] = dist[r][c] + 1 // Distance is one more than current cell
				q.PushBack([2]int{nr, nc})    // Add neighbor to queue
			}
		}
	}

	// Step 2: Binary search on the answer (maximum possible safeness factor for a path)
	// The maximum possible safeness factor is bounded by 2*(n-1) (e.g., from one corner to the opposite).
	low := 0
	high := 2 * (n - 1) // Safe upper bound for the safeness factor
	ans := 0

	// check function: determines if a path exists from (0,0) to (n-1, n-1)
	// where every cell in the path has a safeness factor of at least 'k'.
	check := func(k int) bool {
		// If the starting cell itself doesn't meet the safeness requirement, no path can exist.
		if dist[0][0] < k {
			return false
		}

		// BFS to find a path
		visited := make([][]bool, n)
		for i := 0; i < n; i++ {
			visited[i] = make([]bool, n)
		}

		qBFS := list.New()
		qBFS.PushBack([2]int{0, 0})
		visited[0][0] = true

		for qBFS.Len() > 0 {
			curr := qBFS.Remove(qBFS.Front()).([2]int)
			r, c := curr[0], curr[1]

			// If destination reached, a path exists
			if r == n-1 && c == n-1 {
				return true
			}

			for _, dir := range dirs {
				nr, nc := r+dir.r, c+dir.c
				// Check bounds, if not visited, and if the neighbor's safeness factor meets the requirement 'k'
				if nr >= 0 && nr < n && nc >= 0 && nc < n && !visited[nr][nc] && dist[nr][nc] >= k {
					visited[nr][nc] = true
					qBFS.PushBack([2]int{nr, nc})
				}
			}
		}
		return false // Destination not reachable with current safeness factor k
	}

	// Binary search loop
	for low <= high {
		mid := low + (high-low)/2
		if check(mid) {
			ans = mid         // A path exists with safeness 'mid', try for a higher one
			low = mid + 1
		} else {
			high = mid - 1 // No path with safeness 'mid', need a lower one
		}
	}

	return ans
}