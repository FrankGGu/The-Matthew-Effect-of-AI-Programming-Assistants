package main

import (
	"sort"
)

type Solution struct {
	st *SegmentTree
}

type SegmentTree struct {
	tree        []int   // Stores the sum of lengths of colored segments.
	lazy        []int   // Lazy tags: 0 (no lazy), 1 (color), 2 (uncolor).
	points      []int   // Sorted unique coordinates from L and R+1 values.
	nCompressed int     // Number of elementary intervals in the compressed space.
}

func NewSegmentTree(queries [][3]int) *SegmentTree {
	coordsSet := make(map[int]bool)
	for _, q := range queries {
		if q[0] == 1 { // Assuming type 1 is a 'color' operation
			coordsSet[q[1]] = true     // L
			coordsSet[q[2]+1] = true // R+1
		}
	}

	points := make([]int, 0, len(coordsSet))
	for coord := range coordsSet {
		points = append(points, coord)
	}
	sort.Ints(points)

	nCompressed := len(points) - 1
	if nCompressed <= 0 { // Handle cases with no valid intervals or only one point
		return &SegmentTree{
			points:      points,
			nCompressed: 0,
		}
	}

	return &SegmentTree{
		tree:        make([]int, 4*nCompressed),
		lazy:        make([]int, 4*nCompressed),
		points:      points,
		nCompressed: nCompressed,
	}
}

func (st *SegmentTree) pushDown(node, start, end int) {
	if st.lazy[node] == 0 || start == end {
		return
	}

	// Apply lazy tag to children
	st.lazy[2*node] = st.lazy[node]
	st.lazy[2*node+1] = st.lazy[node]

	// Update children's tree values based on lazy tag
	mid := (start + end) / 2
	st.applyLazy(2*node, start, mid, st.lazy[node])
	st.applyLazy(2*node+1, mid+1, end, st.lazy[node])

	st.lazy[node] = 0 // Clear parent's lazy tag
}

func (st *SegmentTree) applyLazy(node, start, end, tag int) {
	if tag == 1 { // Color operation
		st.tree[node] = st.points[end+1] - st.points[start] // Entire segment is colored
	} else if tag == 2 { // Uncolor operation
		st.tree[node] = 0 // Entire segment is uncolored
	}
}

func (st *SegmentTree) update(node, start, end, queryL, queryR, opType int) {
	// If current segment is outside query range, return.
	if start > queryR || end < queryL {
		return
	}

	// If current segment is fully within query range, apply lazy tag and update tree value.
	if queryL <= start && end <= queryR {
		st.lazy[node] = opType
		st.applyLazy(node, start, end, opType)
		return
	}

	// Push down lazy tag before recursing
	st.pushDown(node, start, end)

	mid := (start + end) / 2
	st.update(2*node, start, mid, queryL, queryR, opType)
	st.update(2*node+1, mid+1, end, queryL, queryR, opType)

	// Combine results from children
	st.tree[node] = st.tree[2*node] + st.tree[2*node+1]
}

func Constructor(queries [][3]int) Solution {
	st := NewSegmentTree(queries)
	return Solution{st: st}
}

func (s *Solution) Color(L int, R int) {
	if s.st.nCompressed == 0 {
		return
	}

	// Find indices for L and R+1 in the compressed coordinate space.
	// sort.SearchInts returns the smallest index i where points[i] >= L.
	idxL := sort.SearchInts(s.st.points, L)
	idxRPlus1 := sort.SearchInts(s.st.points, R+1)

	// The range to update in the segment tree is [idxL, idxRPlus1-1].
	// This covers all elementary intervals [points[i], points[i+1]-1]
	// where points[i] >= L and points[i+1]-1 <= R.
	if idxL >= idxRPlus1 { // If L >= R+1, or L and R+1 map to the same point, no valid range.
		return
	}
	s.st.update(1, 0, s.st.nCompressed-1, idxL, idxRPlus1-1, 1) // 1 for color
}

func (s *Solution) GetColoredCount() int {
	if s.st.nCompressed == 0 {
		return 0
	}
	return s.st.tree[1] // The root node stores the total sum of lengths of colored segments.
}