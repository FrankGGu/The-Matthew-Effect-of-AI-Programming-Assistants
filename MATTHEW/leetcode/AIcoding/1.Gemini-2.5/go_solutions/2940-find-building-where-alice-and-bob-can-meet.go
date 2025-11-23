package main

type SegTreeNode struct {
	maxH int
}

var tree []SegTreeNode // The segment tree array
var N int             // Number of buildings

func update(v, tl, tr, pos, new_val int) {
	if tl == tr {
		tree[v].maxH = new_val // Update leaf node
	} else {
		tm := (tl + tr) / 2
		if pos <= tm {
			update(2*v, tl, tm, pos, new_val) // Update left child
		} else {
			update(2*v+1, tm+1, tr, pos, new_val) // Update right child
		}
		tree[v].maxH = max(tree[2*v].maxH, tree[2*v+1].maxH) // Update parent
	}
}

func query(v, tl, tr, query_l, query_r, required_height int) int {
	// If the current node's range is outside the query range, or if its max height is too low
	// This check also handles cases where query_l > query_r (empty query range).
	if query_l > query_r || tree[v].maxH < required_height {
		return -1
	}

	// If it's a leaf node and its height meets the requirement, this is the smallest index
	if tl == tr {
		return tl
	}

	tm := (tl + tr) / 2
	res := -1

	// Try to find in the left child's range first, as we need the smallest index.
	// The left child covers [tl, tm]. We query the intersection with [query_l, query_r].
	left_query_l := query_l
	left_query_r := min(query_r, tm)
	if left_query_l <= left_query_r { // Check if the intersection is valid
		res = query(2*v, tl, tm, left_query_l, left_query_r, required_height)
	}

	if res != -1 {
		return res // If found in the left child, it's the smallest possible index, so return immediately.
	}

	// If not found in the left child, try the right child's range.
	// The right child covers [tm+1, tr]. We query the intersection with [query_l, query_r].
	right_query_l := max(query_l, tm+1)
	right_query_r := query_r
	if right_query_l <= right_query_r { // Check if the intersection is valid
		res = query(2*v+1, tm+1, tr, right_query_l, right_query_r, required_height)
	}

	return res
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

func findBuildings(heights []int, queries [][]int) []int {
	N = len(heights)
	Q := len(queries)
	ans := make([]int, Q) // To store results for each query

	// query_data[i] will store queries where max(Alice_start_idx, Bob_start_idx) == i.
	// Each stored query is represented as []int{required_height, original_query_idx}.
	query_data := make([][][]int, N)
	for q_idx, q_pair := range queries {
		a, b := q_pair[0], q_pair[1]
		start_idx := max(a, b) // The meeting building k must be >= start_idx
		req_height := max(heights[a], heights[b]) // The meeting building k must be >= req_height
		query_data[start_idx] = append(query_data[start_idx], []int{req_height, q_idx})
	}

	// Initialize the segment tree.
	// `make` initializes struct fields to their zero values (0 for int), so `maxH` is 0.
	tree = make([]SegTreeNode, 4*N)

	// Process buildings from right to left (N-1 down to 0).
	// This allows us to use the segment tree to query for buildings at or to the right of the current index `i`.
	for i := N - 1; i >= 0; i-- {
		// Add the current building's height to the segment tree.
		// Now, buildings from index `i` to `N-1` have their actual heights in the tree.
		// Buildings `0` to `i-1` still effectively have height 0.
		update(1, 0, N-1, i, heights[i])

		// Process all queries that have `start_idx == i`.
		for _, q_info := range query_data[i] {
			req_height := q_info[0]
			original_idx := q_info[1]

			// Query the segment tree for the smallest index k in the range [i, N-1]
			// such that heights[k] >= req_height.
			result_k := query(1, 0, N-1, i, N-1, req_height)
			ans[original_idx] = result_k
		}
	}

	return ans
}