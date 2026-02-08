import (
	"math"
	"sort"
)

func longestSubsequenceWithDecreasingAdjacentDifference(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return n
	}

	// 1. Collect all possible absolute differences and coordinate compress them.
	// Include math.MaxInt32 as a sentinel for the "previous difference" of the first element in a subsequence.
	// This sentinel ensures any actual difference will be strictly smaller.
	diffSet := make(map[int]bool)
	diffSet[math.MaxInt32] = true // Sentinel for the first element
	for i := 0; i < n; i++ {
		for j := 0; j < i; j++ {
			diffSet[abs(nums[i]-nums[j])] = true
		}
	}

	allAbsDiffs := make([]int, 0, len(diffSet))
	for diff := range diffSet {
		allAbsDiffs = append(allAbsDiffs, diff)
	}
	sort.Ints(allAbsDiffs) // Sorts differences in ascending order

	diffMap := make(map[int]int) // Maps actual difference value to its compressed index
	for i, diff := range allAbsDiffs {
		diffMap[diff] = i
	}
	numDiffTypes := len(allAbsDiffs)

	// 2. Initialize DP structures.
	// dpTrees[i] will be a segment tree storing max lengths for subsequences ending at nums[i].
	// Each segment tree maps compressed_abs_diff_idx to the maximum length of a subsequence
	// ending at nums[i] with that specific last absolute difference.
	dpTrees := make([]*SegmentTree, n)
	overallMaxLen := 0

	for i := 0; i < n; i++ {
		currentNum := nums[i]

		// Create a new segment tree for nums[i].
		// This tree will store lengths of subsequences ending at nums[i],
		// indexed by the compressed_abs_diff_idx of the last difference.
		currentTree := newSegmentTree(numDiffTypes)

		// A subsequence of length 1 ending at nums[i] has no preceding difference.
		// We model this by assigning a "previous difference" of math.MaxInt32 (sentinel).
		// Update currentTree with length 1 for this sentinel difference.
		currentTree.update(diffMap[math.MaxInt32], 1)

		overallMaxLen = max(overallMaxLen, 1)

		for j := 0; j < i; j++ {
			prevNum := nums[j]
			prevTree := dpTrees[j] // Segment tree for subsequences ending at nums[j]

			currentAbsDiff := abs(currentNum - prevNum)
			currentAbsDiffIdx := diffMap[currentAbsDiff]

			// Query prevTree: find max_len for any prev_abs_diff_idx such that
			// prev_abs_diff_idx > current_abs_diff_idx.
			// This corresponds to querying the range (currentAbsDiffIdx + 1, numDiffTypes - 1)
			// in the compressed difference space.
			maxPrevLen := prevTree.query(currentAbsDiffIdx+1, numDiffTypes-1)

			if maxPrevLen > 0 { // If a valid previous subsequence was found
				newLen := maxPrevLen + 1
				// Update currentTree: store newLen for currentAbsDiffIdx.
				// We take the max because multiple previous subsequences might lead to the same
				// current_abs_diff and end at currentNum.
				currentTree.update(currentAbsDiffIdx, newLen)
				overallMaxLen = max(overallMaxLen, newLen)
			}
		}
		dpTrees[i] = currentTree // Store the segment tree for nums[i]
	}

	return overallMaxLen
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

type SegmentTree struct {
	tree []int
	size int // Number of leaf nodes (compressed difference types)
}

func newSegmentTree(n int) *SegmentTree {
	return &SegmentTree{
		tree: make([]int, 4*n), // 4*n is a common safe size for segment tree array
		size: n,
	}
}

func (st *SegmentTree) update(idx, val int) {
	st.updateRec(1, 0, st.size-1, idx, val)
}

func (st *SegmentTree) updateRec(node, start, end, idx, val int) {
	if start == end { // Leaf node
		st.tree[node] = max(st.tree[node], val) // Store max length
		return
	}
	mid := (start + end) / 2
	if start <= idx && idx <= mid { // idx is in the left child's range
		st.updateRec(2*node, start, mid, idx, val)
	} else { // idx is in the right child's range
		st.updateRec(2*node+1, mid+1, end, idx, val)
	}
	// Update parent node with the maximum of its children
	st.tree[node] = max(st.tree[2*node], st.tree[2*node+1])
}

func (st *SegmentTree) query(l, r int) int {
	if l > r { // Query range is invalid or empty
		return 0
	}
	return st.queryRec(1, 0, st.size-1, l, r)
}

func (st *SegmentTree) queryRec(node, start, end, l, r int) int {
	if r < start || end < l { // Current segment is completely outside query range
		return 0
	}
	if l <= start && end <= r { // Current segment is completely inside query range
		return st.tree[node]
	}
	// Current segment partially overlaps, query children
	mid := (start + end) / 2
	p1 := st.queryRec(2*node, start, mid, l, r)
	p2 := st.queryRec(2*node+1, mid+1, end, l, r)
	return max(p1, p2)
}