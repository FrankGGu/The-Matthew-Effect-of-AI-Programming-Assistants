package main

import (
	"sort"
)

type SegmentTree struct {
	tree []int
	lazy []int
}

func newSegmentTree(n int) *SegmentTree {
	return &SegmentTree{
		tree: make([]int, 4*n),
		lazy: make([]int, 4*n),
	}
}

func (st *SegmentTree) max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func (st *SegmentTree) pushDown(node int) {
	if st.lazy[node] != 0 {
		st.tree[2*node] = st.max(st.tree[2*node], st.lazy[node])
		st.lazy[2*node] = st.max(st.lazy[2*node], st.lazy[node])
		st.tree[2*node+1] = st.max(st.tree[2*node+1], st.lazy[node])
		st.lazy[2*node+1] = st.max(st.lazy[2*node+1], st.lazy[node])
		st.lazy[node] = 0
	}
}

func (st *SegmentTree) query(node, start, end, l, r int) int {
	if r < start || l > end {
		return 0
	}
	if l <= start && end <= r {
		return st.tree[node]
	}

	st.pushDown(node)

	mid := (start + end) / 2
	p1 := st.query(2*node, start, mid, l, r)
	p2 := st.query(2*node+1, mid+1, end, l, r)
	return st.max(p1, p2)
}

func (st *SegmentTree) update(node, start, end, l, r, val int) {
	if r < start || l > end {
		return
	}
	if l <= start && end <= r {
		st.tree[node] = st.max(st.tree[node], val)
		st.lazy[node] = st.max(st.lazy[node], val)
		return
	}

	st.pushDown(node)

	mid := (start + end) / 2
	st.update(2*node, start, mid, l, r, val)
	st.update(2*node+1, mid+1, end, l, r, val)

	st.tree[node] = st.max(st.tree[2*node], st.tree[2*node+1])
}

func fallingSquares(positions [][]int) []int {
	coordSet := make(map[int]struct{})
	for _, pos := range positions {
		left := pos[0]
		side := pos[1]
		coordSet[left] = struct{}{}
		coordSet[left+side] = struct{}{}
	}

	coords := make([]int, 0, len(coordSet))
	for c := range coordSet {
		coords = append(coords, c)
	}
	sort.Ints(coords)

	coordMap := make(map[int]int)
	for i, c := range coords {
		coordMap[c] = i
	}

	numIntervals := len(coords) - 1
	if numIntervals <= 0 {
		return make([]int, len(positions))
	}

	st := newSegmentTree(numIntervals)

	result := make([]int, len(positions))
	maxOverallHeight := 0

	for i, pos := range positions {
		left := pos[0]
		side := pos[1]
		right := left + side

		lIdx := coordMap[left]
		rIdx := coordMap[right] - 1

		currentMaxHeight := st.query(1, 0, numIntervals-1, lIdx, rIdx)

		newSquareHeight := currentMaxHeight + side

		st.update(1, 0, numIntervals-1, lIdx, rIdx, newSquareHeight)

		maxOverallHeight = st.max(maxOverallHeight, newSquareHeight)
		result[i] = maxOverallHeight
	}

	return result
}