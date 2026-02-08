package main

import (
	"sort"
)

type DSU struct {
	parent []int
	size   []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	size := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
	}
	return &DSU{parent: parent, size: size}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) {
	rootI := d.find(i)
	rootJ := d.find(j)
	if rootI != rootJ {
		if d.size[rootI] < d.size[rootJ] {
			rootI, rootJ = rootJ, rootI
		}
		d.parent[rootJ] = rootI
		d.size[rootI] += d.size[rootJ]
	}
}

type SegTree struct {
	tree []int
	n    int // size of the compressed value range
}

func newSegTree(size int, initialVal int) *SegTree {
	tree := make([]int, 2*size) // Using 0-indexed array, size 2*N for leaves and internal nodes
	for i := range tree {
		tree[i] = initialVal
	}
	return &SegTree{tree: tree, n: size}
}

func (st *SegTree) update(idx, val int) {
	// idx is compressed index, map to leaf node
	idx += st.n
	st.tree[idx] = min(st.tree[idx], val) // Store minimum index for this compressed value
	for idx > 1 {
		idx /= 2
		st.tree[idx] = min(st.tree[idx*2], st.tree[idx*2+1])
	}
}

func (st *SegTree) query(l, r int) int { // query range [l, r] inclusive (compressed indices)
	res := st.n // Initialize with a value larger than any possible index (N)
	if l > r || l >= st.n || r < 0 { // empty or invalid range
		return res
	}
	l += st.n
	r += st.n
	for l <= r {
		if l%2 == 1 {
			res = min(res, st.tree[l])
			l++
		}
		if r%2 == 0 {
			res = min(res, st.tree[r])
			r--
		}
		l /= 2
		r /= 2
	}
	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func makeLexicographicallySmallestArray(nums []int, limit int) []int {
	n := len(nums)
	if n == 0 {
		return []int{}
	}

	// 1. Coordinate compression
	allVals := make([]int, n)
	copy(allVals, nums)
	sort.Ints(allVals)

	uniqueVals := make([]int, 0, n)
	if n > 0 {
		uniqueVals = append(uniqueVals, allVals[0])
		for i := 1; i < n; i++ {
			if allVals[i] != allVals[i-1] {
				uniqueVals = append(uniqueVals, allVals[i])
			}
		}
	}

	valToCompressedIdx := make(map[int]int, len(uniqueVals))
	for i, val := range uniqueVals {
		valToCompressedIdx[val] = i
	}

	// 2. Initialize DSU
	dsu := newDSU(n)

	// 3. Initialize Segment Tree
	// The segment tree stores the minimum index `j` for `nums[j]` in a given value range.
	// `n` is used as initial value because it's an invalid index, larger than any 0..n-1.
	segTree := newSegTree(len(uniqueVals), n)

	// 4. Iterate and connect components
	for i := 0; i < n; i++ {
		currentNum := nums[i]

		// Calculate query value range
		minQueryVal := currentNum - limit
		maxQueryVal := currentNum + limit

		// Find compressed index range for the query value range
		// sort.SearchInts returns the smallest index i where uniqueVals[i] >= value.
		queryCompressedMinIdx := sort.SearchInts(uniqueVals, minQueryVal)
		// sort.SearchInts(uniqueVals, maxQueryVal + 1) returns the smallest index i where uniqueVals[i] > maxQueryVal.
		queryCompressedMaxIdx := sort.SearchInts(uniqueVals, maxQueryVal+1) - 1

		// Query the segment tree for the minimum index j_found in the value range
		jFound := segTree.query(queryCompressedMinIdx, queryCompressedMaxIdx)

		// If a valid j_found is found and it's within the index limit, union i and j_found
		if jFound < n && i-jFound <= limit { // jFound < n means it's a valid index
			dsu.union(i, jFound)
		}

		// Update the segment tree with the current index i and its value
		// This makes nums[i] available for future connections (k > i)
		segTree.update(valToCompressedIdx[currentNum], i)
	}

	// 5. Group values and indices by component, then sort and assign
	componentValues := make(map[int][]int)
	componentIndices := make(map[int][]int)

	for i := 0; i < n; i++ {
		root := dsu.find(i)
		componentValues[root] = append(componentValues[root], nums[i])
		componentIndices[root] = append(componentIndices[root], i)
	}

	result := make([]int, n)
	for root := range componentValues {
		sort.Ints(componentValues[root])
		sort.Ints(componentIndices[root])
		for k := 0; k < len(componentValues[root]); k++ {
			result[componentIndices[root][k]] = componentValues[root][k]
		}
	}

	return result
}