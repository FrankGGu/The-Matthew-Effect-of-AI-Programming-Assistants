import (
	"sort"
)

type Interval struct {
	Start int
	End   int
}

type SegTree struct {
	tree []int
	size int
}

func newSegTree(n int) *SegTree {
	return &SegTree{
		tree: make([]int, 4*n), // A common heuristic for segment tree array size
		size: n,
	}
}

func (st *SegTree) update(node, start, end, idx, val int) {
	if start == end {
		st.tree[node] = max(st.tree[node], val)
		return
	}
	mid := (start + end) / 2
	if start <= idx && idx <= mid {
		st.update(2*node, start, mid, idx, val)
	} else {
		st.update(2*node+1, mid+1, end, idx, val)
	}
	st.tree[node] = max(st.tree[2*node], st.tree[2*node+1])
}

func (st *SegTree) query(node, start, end, l, r int) int {
	if r < start || end < l { // Current segment completely outside query range
		return 0
	}
	if l <= start && end <= r { // Current segment completely inside query range
		return st.tree[node]
	}
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

func maximizeSubarraysAfterRemovingOneConflictingPair(intervals [][]int) int {
	n := len(intervals)
	if n == 0 {
		return 0
	}

	// Convert to custom struct for easier sorting
	intvs := make([]Interval, n)
	for i := 0; i < n; i++ {
		intvs[i] = Interval{Start: intervals[i][0], End: intervals[i][1]}
	}

	// Sort intervals by start time, then by end time
	sort.Slice(intvs, func(i, j int) bool {
		if intvs[i].Start != intvs[j].Start {
			return intvs[i].Start < intvs[j].Start
		}
		return intvs[i].End < intvs[j].End
	})

	// Coordinate compression
	// Collect all unique start and end coordinates
	allCoords := make(map[int]bool)
	for _, iv := range intvs {
		allCoords[iv.Start] = true
		allCoords[iv.End] = true
	}

	coordsList := make([]int, 0, len(allCoords))
	for coord := range allCoords {
		coordsList = append(coordsList, coord)
	}
	sort.Ints(coordsList)

	// Map original coordinate values to their compressed indices
	coordToIdx := make(map[int]int)
	for i, coord := range coordsList {
		coordToIdx[coord] = i
	}

	M := len(coordsList) // Size of the compressed coordinate space

	// Initialize two segment trees:
	// segDp0: stores max lengths of non-conflicting chains
	// segDp1: stores max lengths of chains that used exactly one conflict allowance
	segDp0 := newSegTree(M)
	segDp1 := newSegTree(M)

	ans := 0

	// Iterate through sorted intervals
	for _, iv := range intvs {
		sIdx := coordToIdx[iv.Start] // Compressed index for interval's start
		eIdx := coordToIdx[iv.End]   // Compressed index for interval's end

		currentDp0 := 1 // Base case: the interval itself forms a chain of length 1 (no conflict)
		currentDp1 := 1 // Base case: the interval itself forms a chain of length 1 (no conflict used yet, but available)

		// Calculate currentDp0: max non-overlapping chain ending at iv
		// This extends a previous non-conflicting chain `j` such that `j.End <= iv.Start`.
		// Query segDp0 for max(dp0[j]) in the range [0, sIdx]
		prevMaxDp0 := 0
		if sIdx >= 0 {
			prevMaxDp0 = segDp0.query(1, 0, M-1, 0, sIdx)
		}
		currentDp0 = max(currentDp0, prevMaxDp0+1)

		// Calculate currentDp1: max chain ending at iv, having used one conflict allowance
		// Case 1: Extend a chain that already used a conflict, with no new conflict
		// This extends a previous conflicting chain `j` such that `j.End <= iv.Start`.
		// Query segDp1 for max(dp1[j]) in the range [0, sIdx]
		prevMaxDp1 := 0
		if sIdx >= 0 {
			prevMaxDp1 = segDp1.query(1, 0, M-1, 0, sIdx)
		}
		currentDp1 = max(currentDp1, prevMaxDp1+1)

		// Case 2: Use the conflict allowance between a non-conflicting chain ending at `j` and `iv`
		// This means `j.End > iv.Start`.
		// The chain up to `j` must have been non-conflicting (state `dp0[j]`).
		// If `j` and `iv` conflict, and we use our allowance, they effectively contribute 1 interval
		// to the total count (by removing one of them). So the new length is `dp0[j]`.
		// Query segDp0 for max(dp0[j]) in the range [sIdx+1, M-1]
		prevMaxDp0Overlap := 0
		if sIdx+1 < M { // Ensure query range is valid
			prevMaxDp0Overlap = segDp0.query(1, 0, M-1, sIdx+1, M-1)
		}
		currentDp1 = max(currentDp1, prevMaxDp0Overlap)

		// Update segment trees with the calculated current values for interval iv's end coordinate
		segDp0.update(1, 0, M-1, eIdx, currentDp0)
		segDp1.update(1, 0, M-1, eIdx, currentDp1)

		// Update overall maximum answer
		ans = max(ans, currentDp0)
		ans = max(ans, currentDp1)
	}

	return ans
}