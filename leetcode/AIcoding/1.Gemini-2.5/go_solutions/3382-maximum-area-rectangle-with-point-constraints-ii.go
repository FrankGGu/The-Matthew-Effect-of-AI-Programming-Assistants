import (
	"math"
	"sort"
)

type Point struct {
	x, y     int
	is_valid bool // true if y >= x, false if y < x
}

type Node struct {
	minY, maxY   int // min/max y of valid points in this segment (only if countInvalid == 0)
	maxDiff      int // max(maxY - minY) in a valid sub-segment
	invalidCount int // number of invalid points in this segment
}

var yCoords []int // Sorted unique y coordinates
var tree []Node
var N_y int // Number of unique y coordinates

const (
	INF_Y     = math.MaxInt // Using math.MaxInt for Go's default int (int64)
	NEG_INF_Y = math.MinInt // Using math.MinInt for Go's default int (int64)
)

var validPointCountsAtYIdx []int
var invalidPointCountsAtYIdx []int

func build(idx, start, end int) {
	if start == end {
		tree[idx] = Node{minY: INF_Y, maxY: NEG_INF_Y, maxDiff: -1, invalidCount: 0}
		return
	}
	mid := (start + end) / 2
	build(2*idx, start, mid)
	build(2*idx+1, mid+1, end)
	tree[idx] = Node{minY: INF_Y, maxY: NEG_INF_Y, maxDiff: -1, invalidCount: 0} // Initialize parent node
}

func update(idx, start, end, y_idx int, p Point, delta int) {
	if start == end {
		// Update auxiliary counts
		if p.is_valid {
			validPointCountsAtYIdx[y_idx] += delta
		} else {
			invalidPointCountsAtYIdx[y_idx] += delta
		}

		// Recompute leaf node's values based on counts
		currYVal := yCoords[y_idx]
		if validPointCountsAtYIdx[y_idx] > 0 {
			tree[idx].minY = currYVal
			tree[idx].maxY = currYVal
		} else {
			tree[idx].minY = INF_Y
			tree[idx].maxY = NEG_INF_Y
		}
		tree[idx].invalidCount = invalidPointCountsAtYIdx[y_idx]

		if tree[idx].invalidCount == 0 && validPointCountsAtYIdx[y_idx] > 0 {
			tree[idx].maxDiff = 0 // A single point forms a rectangle of 0 height
		} else {
			tree[idx].maxDiff = -1
		}
		return
	}

	mid := (start + end) / 2
	if y_idx <= mid {
		update(2*idx, start, mid, y_idx, p, delta)
	} else {
		update(2*idx+1, mid+1, end, y_idx, p, delta)
	}
	pushUp(idx)
}

func pushUp(idx int) {
	left := tree[2*idx]
	right := tree[2*idx+1]

	tree[idx].invalidCount = left.invalidCount + right.invalidCount

	if tree[idx].invalidCount > 0 {
		tree[idx].minY = INF_Y
		tree[idx].maxY = NEG_INF_Y
		tree[idx].maxDiff = -1
	} else {
		tree[idx].minY = min(left.minY, right.minY)
		tree[idx].maxY = max(left.maxY, right.maxY)

		tree[idx].maxDiff = max(left.maxDiff, right.maxDiff)
		if left.maxY != NEG_INF_Y && right.minY != INF_Y {
			tree[idx].maxDiff = max(tree[idx].maxDiff, right.maxY-left.minY)
		}
	}
}

func maxAreaRectangleWithPointConstraints(points [][]int, w int) int {
	allPoints := make([]Point, len(points))
	uniqueYMap := make(map[int]bool)
	for i, p := range points {
		allPoints[i] = Point{x: p[0], y: p[1], is_valid: p[1] >= p[0]}
		uniqueYMap[p[1]] = true
	}

	// Coordinate compress y-coordinates
	yCoords = make([]int, 0, len(uniqueYMap))
	for y := range uniqueYMap {
		yCoords = append(yCoords, y)
	}
	sort.Ints(yCoords)

	yToIdx := make(map[int]int)
	for i, y := range yCoords {
		yToIdx[y] = i
	}
	N_y = len(yCoords)

	// Sort all points by x-coordinate
	sort.Slice(allPoints, func(i, j int) bool {
		return allPoints[i].x < allPoints[j].x
	})

	// Initialize segment tree
	tree = make([]Node, 4*N_y) // Max size for segment tree
	build(1, 0, N_y-1)

	validPointCountsAtYIdx = make([]int, N_y)
	invalidPointCountsAtYIdx = make([]int, N_y)

	maxArea := 0
	leftPtr := 0

	for rightPtr := 0; rightPtr < len(allPoints); rightPtr++ {
		// Add point at rightPtr
		p := allPoints[rightPtr]
		update(1, 0, N_y-1, yToIdx[p.y], p, 1)

		// Shrink window from left if width constraint exceeded
		for allPoints[rightPtr].x-allPoints[leftPtr].x > w {
			p_remove := allPoints[leftPtr]
			update(1, 0, N_y-1, yToIdx[p_remove.y], p_remove, -1)
			leftPtr++
		}

		// Query segment tree for max y_diff in current window [leftPtr, rightPtr]
		// The root node (tree[1]) contains the info for the entire y-range.
		// If tree[1].maxDiff is > -1, it means a valid rectangle exists.
		if tree[1].maxDiff > -1 {
			currentXDiff := allPoints[rightPtr].x - allPoints[leftPtr].x
			currentArea := currentXDiff * tree[1].maxDiff
			if currentArea > maxArea {
				maxArea = currentArea
			}
		}
	}

	return maxArea
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}