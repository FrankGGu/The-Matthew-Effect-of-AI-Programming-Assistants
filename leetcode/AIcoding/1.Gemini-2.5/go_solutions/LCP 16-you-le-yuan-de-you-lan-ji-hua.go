package main

import (
	"sort"
)

type SegmentTree struct {
	tree []int
	size int // number of distinct elements
}

func newSegmentTree(n int) *SegmentTree {
	tree := make([]int, 4*n)
	for i := range tree {
		tree[i] = -1 // Initialize with -1, indicating no valid sum yet
	}
	return &SegmentTree{tree: tree, size: n}
}

func (st *SegmentTree) update(node, start, end, idx, val int) {
	if start == end {
		st.tree[node] = max(st.tree[node], val)
		return
	}
	mid := start + (end-start)/2
	if idx <= mid {
		st.update(2*node+1, start, mid, idx, val)
	} else {
		st.update(2*node+2, mid+1, end, idx, val)
	}
	st.tree[node] = max(st.tree[2*node+1], st.tree[2*node+2])
}

func (st *SegmentTree) query(node, start, end, l, r int) int {
	// If current segment range is completely outside query range
	if r < start || end < l || l > r { // l > r handles invalid query ranges like [5, 4]
		return -1
	}
	// If current segment range is completely within query range
	if l <= start && end <= r {
		return st.tree[node]
	}
	// Partial overlap, recurse
	mid := start + (end-start)/2
	p1 := st.query(2*node+1, start, mid, l, r)
	p2 := st.query(2*node+2, mid+1, end, l, r)
	return max(p1, p2)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumSumQueries(nums1 []int, nums2 []int, queries [][]int) []int {
	n := len(nums1)
	m := len(queries)

	points := make([][2]int, n)
	for i := 0; i < n; i++ {
		points[i] = [2]int{nums1[i], nums2[i]}
	}

	queryData := make([][3]int, m)
	for i := 0; i < m; i++ {
		queryData[i] = [3]int{queries[i][0], queries[i][1], i}
	}

	// Sort points by nums1[i] descending
	sort.Slice(points, func(i, j int) bool {
		return points[i][0] > points[j][0]
	})

	// Sort queries by xi descending
	sort.Slice(queryData, func(i, j int) bool {
		return queryData[i][0] > queryData[j][0]
	})

	// Collect all unique nums2 values for coordinate compression
	uniqueNums2Set := make(map[int]struct{})
	for _, p := range points {
		uniqueNums2Set[p[1]] = struct{}{}
	}
	sortedUniqueNums2 := make([]int, 0, len(uniqueNums2Set))
	for val := range uniqueNums2Set {
		sortedUniqueNums2 = append(sortedUniqueNums2, val)
	}
	sort.Ints(sortedUniqueNums2)

	compressedSize := len(sortedUniqueNums2)
	st := newSegmentTree(compressedSize)
	ans := make([]int, m)

	pointIdx := 0
	for _, q := range queryData {
		xi, yi, originalIdx := q[0], q[1], q[2]

		// Add points where nums1[j] >= xi to the segment tree
		for pointIdx < n && points[pointIdx][0] >= xi {
			n1 := points[pointIdx][0]
			n2 := points[pointIdx][1]
			compressedN2Idx := sort.SearchInts(sortedUniqueNums2, n2)
			st.update(0, 0, compressedSize-1, compressedN2Idx, n1+n2)
			pointIdx++
		}

		// Query the segment tree for max sum where nums2[j] >= yi
		compressedYiIdx := sort.SearchInts(sortedUniqueNums2, yi)

		// The query range is [compressedYiIdx, compressedSize-1]
		// The segment tree query function handles cases where this range is invalid (e.g., compressedYiIdx >= compressedSize)
		ans[originalIdx] = st.query(0, 0, compressedSize-1, compressedYiIdx, compressedSize-1)
	}

	return ans
}