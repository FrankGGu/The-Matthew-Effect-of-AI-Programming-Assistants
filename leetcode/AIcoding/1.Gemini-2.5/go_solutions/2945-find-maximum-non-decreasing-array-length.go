package main

import (
	"sort"
)

type SegmentTree struct {
	size int
	tree []int // Stores max value in range
}

func NewSegmentTree(size int) *SegmentTree {
	// A common safe upper bound for tree array size is 4*size
	return &SegmentTree{
		size: size,
		tree: make([]int, 4*size),
	}
}

func (st *SegmentTree) Update(idx, val int) {
	st.update(1, 0, st.size-1, idx, val)
}

func (st *SegmentTree) update(node, start, end, idx, val int) {
	if start == end {
		st.tree[node] = max(st.tree[node], val)
		return
	}
	mid := (start + end) / 2
	if idx <= mid {
		st.update(2*node, start, mid, idx, val)
	} else {
		st.update(2*node+1, mid+1, end, idx, val)
	}
	st.tree[node] = max(st.tree[2*node], st.tree[2*node+1])
}

func (st *SegmentTree) Query(maxIdx int) int {
	// If maxIdx is out of bounds or negative, return 0 (no previous elements)
	if maxIdx < 0 {
		return 0
	}
	return st.query(1, 0, st.size-1, 0, maxIdx)
}

func (st *SegmentTree) query(node, start, end, l, r int) int {
	// If query range is completely outside current node's range
	if r < start || end < l {
		return 0 // Return 0 as lengths are non-negative
	}
	// If query range completely covers current node's range
	if l <= start && end <= r {
		return st.tree[node]
	}
	// Partial overlap, recurse
	mid := (start + end) / 2
	p1 := st.query(2*node, start, mid, l, r)
	p2 := st.query(2*node+1, mid+1, end, l, r)
	return max(p1, p2)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func findMaximumNonDecreasingArrayLength(nums1 []int, nums2 []int) int {
	n := len(nums1)
	if n == 0 {
		return 0
	}

	allValues := make([]int, 0, 2*n)
	for i := 0; i < n; i++ {
		allValues = append(allValues, nums1[i])
		allValues = append(allValues, nums2[i])
	}
	sort.Ints(allValues)

	coordMap := make(map[int]int)
	compressedIdx := 0
	for _, val := range allValues {
		if _, exists := coordMap[val]; !exists {
			coordMap[val] = compressedIdx
			compressedIdx++
		}
	}
	maxCompressedIdx := compressedIdx // Size of the segment tree (number of unique values)

	segTree := NewSegmentTree(maxCompressedIdx)

	maxOverallLen := 0

	for i := 0; i < n; i++ {
		u := nums1[i]
		v := nums2[i]

		// Ensure u <= v by swapping, as per problem's swap operation.
		// This simplifies choices: we always consider the smaller and larger values available at index i.
		if u > v {
			u, v = v, u
		}

		uComp := coordMap[u]
		vComp := coordMap[v]

		// Calculate lengths for current u and v
		// A single element always forms a non-decreasing sequence of length 1.
		lenU := 1
		lenV := 1

		// Query for u: max length ending with value <= u
		// This finds the longest non-decreasing subsequence ending before index i,
		// whose last element is less than or equal to u.
		prevMaxLenU := segTree.Query(uComp)
		if prevMaxLenU > 0 { // If a valid previous subsequence exists
			lenU = prevMaxLenU + 1
		}

		// Query for v: max length ending with value <= v
		prevMaxLenV := segTree.Query(vComp)
		if prevMaxLenV > 0 { // If a valid previous subsequence exists
			lenV = prevMaxLenV + 1
		}

		// Update max_overall_len with the best lengths found so far
		maxOverallLen = max(maxOverallLen, lenU)
		maxOverallLen = max(maxOverallLen, lenV)

		// Update segment tree with new lengths for u and v
		// We update with the maximum length found for these values at this step `i`.
		// If u and v are the same, the second update will correctly take the max.
		segTree.Update(uComp, lenU)
		segTree.Update(vComp, lenV)
	}

	return maxOverallLen
}