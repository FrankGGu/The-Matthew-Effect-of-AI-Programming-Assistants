package main

import (
	"math"
)

const INF int64 = math.MaxInt64 / 2 // A large enough value for infinity

type SegmentTree struct {
	n    int
	tree []int64
	lazy []int64 // Lazy propagation array for range additions
}

func NewSegmentTree(arr []int64) *SegmentTree {
	n := len(arr)
	tree := make([]int64, 4*n)
	lazy := make([]int64, 4*n)
	st := &SegmentTree{n: n, tree: tree, lazy: lazy}
	st.build(arr, 1, 0, n-1)
	return st
}

func (st *SegmentTree) build(arr []int64, node, start, end int) {
	if start == end {
		st.tree[node] = arr[start]
	} else {
		mid := (start + end) / 2
		st.build(arr, 2*node, start, mid)
		st.build(arr, 2*node+1, mid+1, end)
		st.tree[node] = min(st.tree[2*node], st.tree[2*node+1])
	}
}

func (st *SegmentTree) push(node int) {
	if st.lazy[node] != 0 {
		// Apply lazy value to children
		st.tree[2*node] += st.lazy[node]
		st.lazy[2*node] += st.lazy[node]
		st.tree[2*node+1] += st.lazy[node]
		st.lazy[2*node+1] += st.lazy[node]
		// Reset lazy value for current node
		st.lazy[node] = 0
	}
}

func (st *SegmentTree) updateRange(node, start, end, l, r int, val int64) {
	if start > end || start > r || end < l {
		return
	}
	if l <= start && end <= r {
		st.tree[node] += val
		st.lazy[node] += val
		return
	}
	st.push(node) // Propagate lazy updates before going deeper
	mid := (start + end) / 2
	st.updateRange(2*node, start, mid, l, r, val)
	st.updateRange(2*node+1, mid+1, end, l, r, val)
	st.tree[node] = min(st.tree[2*node], st.tree[2*node+1])
}

func (st *SegmentTree) queryRange(node, start, end, l, r int) int64 {
	if start > end || start > r || end < l {
		return INF
	}
	if l <= start && end <= r {
		return st.tree[node]
	}
	st.push(node) // Propagate lazy updates before going deeper
	mid := (start + end) / 2
	p1 := st.queryRange(2*node, start, mid, l, r)
	p2 := st.queryRange(2*node+1, mid+1, end, l, r)
	return min(p1, p2)
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func minimumSum(nums []int, k int, m int) int64 {
	n := len(nums)

	// dp_prev stores dp[j-1][i] values, dp_curr stores dp[j][i] values.
	// dp[j][i] = minimum sum of j subarrays, where the j-th subarray ends at index i.
	dp_prev := make([]int64, n)
	dp_curr := make([]int64, n)

	// Initialize dp_prev for the first subarray (j=1)
	// The first subarray must contain nums[0]. The chosen element is nums[0].
	// The length must be at least m. So it ends at index i >= m-1.
	for i := 0; i < n; i++ {
		dp_prev[i] = INF
	}
	for i := m - 1; i < n; i++ {
		dp_prev[i] = int64(nums[0])
	}

	// Iterate for j from 2 to k
	for j := 2; j <= k; j++ {
		for i := 0; i < n; i++ {
			dp_curr[i] = INF
		}

		// Initialize segment tree with dp_prev values.
		// The segment tree will implicitly store dp_prev[p] + min(nums[p+1...i]).
		// We initialize it with dp_prev[p] + INF to represent that min(nums[p+1...i]) is
		// initially very large (no suffix considered yet).
		st := NewSegmentTree(dp_prev)
		st.updateRange(1, 0, n-1, 0, n-1, INF) // Add INF to all dp_prev[p]

		// Monotonic stack to find ranges where nums[i] is the minimum.
		// Stores indices x such that nums[x] is decreasing.
		monoStack := []int{}

		for i := 0; i < n; i++ {
			// Update segment tree based on nums[i] becoming the new minimum for certain ranges.
			// When nums[i] is encountered, it might be smaller than previous elements on the stack.
			// For ranges where a popped element `nums[idx]` was the minimum, `nums[i]` now takes over.
			for len(monoStack) > 0 && nums[monoStack[len(monoStack)-1]] >= nums[i] {
				idx := monoStack[len(monoStack)-1]
				monoStack = monoStack[:len(monoStack)-1]

				prevIdx := -1
				if len(monoStack) > 0 {
					prevIdx = monoStack[len(monoStack)-1]
				}

				// For p in [prevIdx + 1, idx], nums[idx] was the minimum in nums[p+1 ... i-1].
				// Now nums[i] is the minimum in nums[p+1 ... i].
				// So, min(nums[p+1 ... i]) changes from nums[idx] to nums[i].
				// We need to add (nums[i] - nums[idx]) to dp_prev[p] for p in this range
				// to reflect this change in the 'min_val_in_range' part of the segment tree.
				if prevIdx+1 <= idx {
					st.updateRange(1, 0, n-1, prevIdx+1, idx, int64(nums[i]-nums[idx]))
				}
			}
			monoStack = append(monoStack, i)

			// For the element nums[i] itself, it can be the minimum of a subarray ending at i.
			// Specifically, for p = i-1, the subarray is nums[i...i], and its minimum is nums[i].
			// The segment tree currently stores dp_prev[i-1] + INF.
			// We need to change this to dp_prev[i-1] + nums[i].
			// This is achieved by subtracting INF and adding nums[i].
			if i > 0 {
				st.updateRange(1, 0, n-1, i-1, i-1, -INF+int64(nums[i]))
			}

			// Query for dp[j][i]
			// The j-th subarray ends at i. Its length must be at least m.
			// So it starts at s, where i - s + 1 >= m => s <= i - m + 1.
			// The (j-1)-th subarray ends at p = s-1. So p <= i - m.
			// The minimum index for j subarrays to end at i is j*m - 1.
			if i >= j*m-1 {
				queryEnd := i - m
				if queryEnd >= 0 {
					dp_curr[i] = st.queryRange(1, 0, n-1, 0, queryEnd)
				}
			}
		}
		dp_prev = dp_curr
	}

	finalMinSum := INF
	// The k-th subarray must end at index i >= k*m - 1.
	for i := k*m - 1; i < n; i++ {
		finalMinSum = min(finalMinSum, dp_prev[i])
	}

	return finalMinSum
}