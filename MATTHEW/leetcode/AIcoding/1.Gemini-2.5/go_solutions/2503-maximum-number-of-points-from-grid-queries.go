import (
	"container/heap"
	"math"
	"sort"
)

type Point struct {
	val int
	r   int
	c   int
}

type MinHeap []Point

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].val < h[j].val }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Point))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type Query struct {
	val int
	idx int
}

func maximumPoints(grid [][]int, queries []int) []int {
	m := len(grid)
	n := len(grid[0])

	// Step 1: Run Dijkstra-like algorithm to find the minimum maximum value on a path from (0,0) to every cell.
	// dist[r][c] will store the minimum of (maximum grid value encountered on any path from (0,0) to (r,c)).
	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32
		}
	}

	pq := &MinHeap{}
	heap.Init(pq)

	// Start from (0,0)
	dist[0][0] = grid[0][0]
	heap.Push(pq, Point{val: grid[0][0], r: 0, c: 0})

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Point)
		currentMaxPathVal := curr.val
		r, c := curr.r, curr.c

		// If we found a shorter path to (r,c) already, skip this one
		if currentMaxPathVal > dist[r][c] {
			continue
		}

		// Explore neighbors
		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				// The new path's maximum value is the max of current path's max and the neighbor's grid value
				newMaxPathVal := currentMaxPathVal
				if grid[nr][nc] > newMaxPathVal {
					newMaxPathVal = grid[nr][nc]
				}

				if newMaxPathVal < dist[nr][nc] {
					dist[nr][nc] = newMaxPathVal
					heap.Push(pq, Point{val: newMaxPathVal, r: nr, c: nc})
				}
			}
		}
	}

	// Step 2: Collect all computed min_max_path_values into a 1D slice and sort it.
	allDistValues := make([]int, 0, m*n)
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if dist[r][c] != math.MaxInt32 { // Only include reachable cells
				allDistValues = append(allDistValues, dist[r][c])
			}
		}
	}
	sort.Ints(allDistValues)

	// Step 3: Process queries using binary search on the sorted min_max_path_values.
	sortedQueries := make([]Query, len(queries))
	for i, qVal := range queries {
		sortedQueries[i] = Query{val: qVal, idx: i}
	}
	sort.Slice(sortedQueries, func(i, j int) bool {
		return sortedQueries[i].val < sortedQueries[j].val
	})

	ans := make([]int, len(queries))

	for _, q := range sortedQueries {
		queryVal := q.val
		originalIdx := q.idx

		// Find the count of cells where min_max_path_value is strictly less than queryVal
		// sort.SearchInts returns the index of the first element >= queryVal.
		// All elements before this index are < queryVal.
		count := sort.SearchInts(allDistValues, queryVal)
		ans[originalIdx] = count
	}

	return ans
}