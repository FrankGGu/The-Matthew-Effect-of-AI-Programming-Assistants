package main

import (
	"container/list"
	"math"
)

type SegmentTree struct {
	size int
	tree []int // Stores sum of 1s in range (1 for unvisited, 0 for visited)
}

func newSegmentTree(n int) *SegmentTree {
	st := &SegmentTree{
		size: n,
		tree: make([]int, 4*n), // 4*n is a common safe size for segment tree arrays
	}
	st.build(1, 0, n-1) // Root node is 1, covers range [0, n-1]
	return st
}

func (st *SegmentTree) build(node, start, end int) {
	if start == end {
		st.tree[node] = 1 // Leaf node: cell is unvisited
		return
	}
	mid := (start + end) / 2
	st.build(2*node, start, mid)     // Build left child
	st.build(2*node+1, mid+1, end) // Build right child
	st.tree[node] = st.tree[2*node] + st.tree[2*node+1] // Sum of children
}

func (st *SegmentTree) update(node, start, end, idx int, val int) {
	if start == end {
		st.tree[node] = val
		return
	}
	mid := (start + end) / 2
	if start <= idx && idx <= mid { // Index is in the left child's range
		st.update(2*node, start, mid, idx, val)
	} else { // Index is in the right child's range
		st.update(2*node+1, mid+1, end, idx, val)
	}
	st.tree[node] = st.tree[2*node] + st.tree[2*node+1] // Update sum
}

func (st *SegmentTree) queryFirstOne(node, start, end, queryStart, queryEnd int) int {
	// If the current node's range is completely outside the query range
	// or if this segment contains no unvisited cells (sum is 0), return -1.
	if queryStart > end || queryEnd < start || st.tree[node] == 0 {
		return -1
	}
	// If we are at a leaf node and it's within the query range and unvisited, return its index.
	if start == end {
		return start
	}

	mid := (start + end) / 2

	// Try to find the first unvisited cell in the left child's range
	res := st.queryFirstOne(2*node, start, mid, queryStart, queryEnd)
	if res != -1 {
		return res // Found in left child
	}

	// If not found in left, try to find in the right child's range
	return st.queryFirstOne(2*node+1, mid+1, end, queryStart, queryEnd)
}

func minimumVisitedCells(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	// Handle edge case: grid[0][0] == 0
	// If it's the destination, 1 cell visited.
	// Otherwise, cannot move, so destination is unreachable.
	if m == 1 && n == 1 {
		return 1
	}
	if grid[0][0] == 0 { 
		return -1
	}

	// dist[r][c] stores the minimum number of cells visited to reach (r, c)
	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32 // Initialize with a large value (infinity)
		}
	}

	// rowSTs[r] is a segment tree for row r, managing visited/unvisited status of columns
	rowSTs := make([]*SegmentTree, m)
	for r := 0; r < m; r++ {
		rowSTs[r] = newSegmentTree(n)
	}

	// colSTs[c] is a segment tree for column c, managing visited/unvisited status of rows
	colSTs := make([]*SegmentTree, n)
	for c := 0; c < n; c++ {
		colSTs[c] = newSegmentTree(m)
	}

	q := list.New() // BFS queue

	// Start at (0, 0)
	dist[0][0] = 1
	q.PushBack([2]int{0, 0})

	// Mark (0,0) as visited in its respective segment trees
	// The root node for update is 1, and the range is [0, n-1] or [0, m-1]
	rowSTs[0].update(1, 0, n-1, 0, 0) // Mark column 0 in row 0 as visited
	colSTs[0].update(1, 0, m-1, 0, 0) // Mark row 0 in column 0 as visited

	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		curr := e.Value.([2]int)
		r, c := curr[0], curr[1]
		d := dist[r][c]

		// Explore horizontal moves
		// Max column index reachable from (r, c)
		maxCol := min(n-1, c+grid[r][c])
		currCol := c // Start searching from the column after 'c'
		for {
			// Find the first unvisited column 'nextCol' in row 'r' within the reachable range
			nextCol := rowSTs[r].queryFirstOne(1, 0, n-1, currCol+1, maxCol)
			if nextCol == -1 { // No unvisited cells found in the current range
				break
			}

			// Update distance, add to queue
			dist[r][nextCol] = d + 1
			q.PushBack([2]int{r, nextCol})

			// Mark (r, nextCol) as visited in both its row and column segment trees
			rowSTs[r].update(1, 0, n-1, nextCol, 0)
			colSTs[nextCol].update(1, 0, m-1, r, 0)

			// If destination reached, return immediately (BFS ensures minimum path)
			if r == m-1 && nextCol == n-1 {
				return d + 1
			}
			currCol = nextCol // Continue searching from the next found column
		}

		// Explore vertical moves
		// Max row index reachable from (r, c)
		maxRow := min(m-1, r+grid[r][c])
		currRow := r // Start searching from the row after 'r'
		for {
			// Find the first unvisited row 'nextRow' in column 'c' within the reachable range
			nextRow := colSTs[c].queryFirstOne(1, 0, m-1, currRow+1, maxRow)
			if nextRow == -1 { // No unvisited cells found in the current range
				break
			}

			// Update distance, add to queue
			dist[nextRow][c] = d + 1
			q.PushBack([2]int{nextRow, c})

			// Mark (nextRow, c) as visited in both its row and column segment trees
			rowSTs[nextRow].update(1, 0, n-1, c, 0)
			colSTs[c].update(1, 0, m-1, nextRow, 0)

			// If destination reached, return immediately
			if nextRow == m-1 && c == n-1 {
				return d + 1
			}
			currRow = nextRow // Continue searching from the next found row
		}
	}

	// If the loop finishes and destination is still MaxInt32, it's unreachable
	if dist[m-1][n-1] == math.MaxInt32 {
		return -1
	}
	return dist[m-1][n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}