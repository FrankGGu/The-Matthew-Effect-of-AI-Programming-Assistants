package main

import (
	"sort"
)

type Pair struct {
	n1 int
	n2 int
}

type Query struct {
	x   int
	y   int
	idx int
}

type SegmentTree struct {
	tree []int
	size int
}

func newSegmentTree(n int) *SegmentTree {
	tree := make([]int, 4*n)
	for i := range tree {
		tree[i] = -1
	}
	return &SegmentTree{tree: tree, size: n}
}

func (st *SegmentTree) update(node, start, end, idx, val int) {
	if start == end {
		st.tree[node] = max(st.tree[node], val)
		return
	}
	mid := (start + end) / 2
	if start <= idx && idx <= mid {
		st.update(2*node+1, start, mid, idx, val)
	} else {
		st.update(2*node+2, mid+1, end, idx, val)
	}
	st.tree[node] = max(st.tree[2*node+1], st.tree[2*node+2])
}

func (st *SegmentTree) query(node, start, end, l, r int) int {
	if r < start || end < l || l > r {
		return -1
	}
	if l <= start && end <= r {
		return st.tree[node]
	}
	mid := (start + end) / 2
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
	qLen := len(queries)

	pairs := make([]Pair, n)
	for i := 0; i < n; i++ {
		pairs[i] = Pair{n1: nums1[i], n2: nums2[i]}
	}

	qList := make([]Query, qLen)
	for i := 0; i < qLen; i++ {
		qList[i] = Query{x: queries[i][0], y: queries[i][1], idx: i}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].n1 > pairs[j].n1
	})

	sort.Slice(qList, func(i, j int) bool {
		return qList[i].x > qList[j].x
	})

	uniqueNums2Map := make(map[int]bool)
	for _, p := range pairs {
		uniqueNums2Map[p.n2] = true
	}
	for _, q := range qList {
		uniqueNums2Map[q.y] = true
	}

	uniqueNums2Values := make([]int, 0, len(uniqueNums2Map))
	for val := range uniqueNums2Map {
		uniqueNums2Values = append(uniqueNums2Values, val)
	}
	sort.Ints(uniqueNums2Values)

	valToCompressedIdx := make(map[int]int)
	for i, val := range uniqueNums2Values {
		valToCompressedIdx[val] = i
	}

	st := newSegmentTree(len(uniqueNums2Values))

	results := make([]int, qLen)
	for i := range results {
		results[i] = -1
	}

	pairPtr := 0
	for _, q := range qList {
		for pairPtr < n && pairs[pairPtr].n1 >= q.x {
			compressedIdx := valToCompressedIdx[pairs[pairPtr].n2]
			st.update(0, 0, len(uniqueNums2Values)-1, compressedIdx, pairs[pairPtr].n1+pairs[pairPtr].n2)
			pairPtr++
		}

		yCompressedStartIdx := sort.SearchInts(uniqueNums2Values, q.y)

		if yCompressedStartIdx < len(uniqueNums2Values) {
			results[q.idx] = st.query(0, 0, len(uniqueNums2Values)-1, yCompressedStartIdx, len(uniqueNums2Values)-1)
		}
	}

	return results
}