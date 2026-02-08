package main

import (
	"sort"
)

type SegmentTree struct {
	tree []int
	size int
}

func NewSegmentTree(n int) *SegmentTree {
	// Find the smallest power of 2 greater than or equal to n
	size := 1
	for size < n {
		size *= 2
	}
	return &SegmentTree{
		tree: make([]int, 2*size),
		size: size,
	}
}

func (st *SegmentTree) update(pos, val int) {
	// Map pos to the leaf node in the segment tree array
	// Our tree uses 0-indexed leaves (0 to st.size-1) mapped to array indices (st.size to 2*st.size-1)
	idx := st.size + pos
	st.tree[idx] = max(st.tree[idx], val)

	// Propagate changes up to the root
	for idx > 1 {
		idx /= 2
		st.tree[idx] = max(st.tree[2*idx], st.tree[2*idx+1])
	}
}

func (st *SegmentTree) query(l, r int) int {
	res := 0 // Initialize result to 0, as an empty subsequence has sum 0.
	// If all elements are negative, we might start a new subsequence with a single element.

	// Map l and r to the segment tree array indices
	l += st.size
	r += st.size + 1 // r becomes exclusive for segment tree traversal

	for l < r {
		if l%2 == 1 { // If l is a right child
			res = max(res, st.tree[l])
			l++
		}
		if r%2 == 1 { // If r is a right child
			r--
			res = max(res, st.tree[r])
		}
		l /= 2
		r /= 2
	}
	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxBalancedSubsequenceSum(nums []int) int {
	n := len(nums)

	// Step 1 & 2: Collect all nums[i] - i values and perform coordinate compression
	coordsMap := make(map[int]int) // value -> compressed_index
	distinctCoords := make([]int, 0, n)

	for i := 0; i < n; i++ {
		val := nums[i] - i
		if _, exists := coordsMap[val]; !exists {
			distinctCoords = append(distinctCoords, val)
		}
	}

	sort.Ints(distinctCoords)

	for i, val := range distinctCoords {
		coordsMap[val] = i
	}

	// Step 3: Initialize Segment Tree
	// The segment tree will store maximum sums for compressed coordinates.
	st := NewSegmentTree(len(distinctCoords))

	// Initialize overall maximum answer.
	// Any single element forms a balanced subsequence. So, the answer must be at least nums[0].
	ans := nums[0] 

	for i := 0; i < n; i++ {
		currentVal := nums[i] - i
		compressedIdx := coordsMap[currentVal]

		// Query for the maximum sum among previous balanced subsequences
		// whose (nums[j] - j) value is less than or equal to currentVal.
		// `prevMaxSum` will be 0 if no such previous subsequence exists or all are negative,
		// allowing the current element to start a new subsequence.
		prevMaxSum := st.query(0, compressedIdx)

		// Calculate the current subsequence sum
		// We add `max(0, prevMaxSum)` to `nums[i]`. If `prevMaxSum` is negative,
		// it means extending a previous subsequence would decrease the sum,
		// so we effectively start a new subsequence with `nums[i]`.
		currentSum := nums[i] + max(0, prevMaxSum)

		// Update the segment tree at the compressed index with the current sum.
		// We take the maximum because multiple (nums[k]-k) values might map to the same compressed index,
		// and we want to store the largest possible sum ending with that (nums[k]-k) value.
		st.update(compressedIdx, currentSum)

		// Update the overall maximum answer
		ans = max(ans, currentSum)
	}

	return ans
}