package main

import (
	"sort"
)

type Node struct {
	okEven    int
	okOdd     int
	notOkEven int
	notOkOdd  int
}

type SegmentTree struct {
	tree []Node
	size int // Number of ranks (unique values)
}

func NewSegmentTree(maxRank int) *SegmentTree {
	treeSize := 4 * maxRank // Max size for segment tree
	tree := make([]Node, treeSize)
	return &SegmentTree{tree: tree, size: maxRank}
}

func (st *SegmentTree) merge(left, right Node) Node {
	return Node{
		okEven:    max(left.okEven, right.okEven),
		okOdd:     max(left.okOdd, right.okOdd),
		notOkEven: max(left.notOkEven, right.notOkEven),
		notOkOdd:  max(left.notOkOdd, right.notOkOdd),
	}
}

func (st *SegmentTree) _update(nodeIdx, low, high, rank int, newOkEven, newOkOdd, newNotOkEven, newNotOkOdd int) {
	if low == high { // Leaf node
		st.tree[nodeIdx].okEven = newOkEven
		st.tree[nodeIdx].okOdd = newOkOdd
		st.tree[nodeIdx].notOkEven = newNotOkEven
		st.tree[nodeIdx].notOkOdd = newNotOkOdd
		return
	}

	mid := low + (high-low)/2
	if rank <= mid {
		st._update(2*nodeIdx, low, mid, rank, newOkEven, newOkOdd, newNotOkEven, newNotOkOdd)
	} else {
		st._update(2*nodeIdx+1, mid+1, high, rank, newOkEven, newOkOdd, newNotOkEven, newNotOkOdd)
	}
	// After updating children, update current node by merging children's results
	st.tree[nodeIdx] = st.merge(st.tree[2*nodeIdx], st.tree[2*nodeIdx+1])
}

func (st *SegmentTree) update(rank int, okEven, okOdd, notOkEven, notOkOdd int) {
	st._update(1, 1, st.size, rank, okEven, okOdd, notOkEven, notOkOdd)
}

func (st *SegmentTree) _query(nodeIdx, low, high, queryLow, queryHigh int) Node {
	// If query range is outside current node's range, or invalid, return identity (all zeros)
	if queryLow > queryHigh || low > high || queryLow > high || queryHigh < low {
		return Node{0, 0, 0, 0}
	}
	// If current node's range is fully within query range, return its value
	if queryLow <= low && high <= queryHigh {
		return st.tree[nodeIdx]
	}

	mid := low + (high-low)/2
	leftRes := st._query(2*nodeIdx, low, mid, queryLow, queryHigh)
	rightRes := st._query(2*nodeIdx+1, mid+1, high, queryLow, queryHigh)
	return st.merge(leftRes, rightRes)
}

func (st *SegmentTree) query(queryLow, queryHigh int) Node {
	return st._query(1, 1, st.size, queryLow, queryHigh)
}

func minPairRemovals(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	// Coordinate compression: map original values to 1-indexed ranks
	uniqueValsMap := make(map[int]bool)
	for _, num := range nums {
		uniqueValsMap[num] = true
	}
	uniqueSortedVals := make([]int, 0, len(uniqueValsMap))
	for val := range uniqueValsMap {
		uniqueSortedVals = append(uniqueSortedVals, val)
	}
	sort.Ints(uniqueSortedVals)

	valToRank := make(map[int]int)
	for i, val := range uniqueSortedVals {
		valToRank[val] = i + 1 // Ranks are 1-indexed
	}
	maxRank := len(uniqueSortedVals)

	// Frequency map for original numbers
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	st := NewSegmentTree(maxRank)

	for _, x := range nums {
		rankX := valToRank[x]
		targetParityX := freqMap[x] % 2 // 0 for even, 1 for odd

		// Query for LNDS ending with values strictly less than x
		prevRes := st.query(1, rankX-1)
		prevOkEven, prevOkOdd, prevNotOkEven, prevNotOkOdd := prevRes.okEven, prevRes.okOdd, prevRes.notOkEven, prevRes.notOkOdd

		// Query for LNDS ending with x itself (current state for rankX)
		currRes := st.query(rankX, rankX)
		currOkEven, currOkOdd, currNotOkEven, currNotOkOdd := currRes.okEven, currRes.okOdd, currRes.notOkEven, currRes.notOkOdd

		// Initialize new max lengths for x
		newOkEven, newOkOdd, newNotOkEven, newNotOkOdd := 0, 0, 0, 0

		// Option 1: Start a new subsequence with x. x's count is 1 (odd).
		if targetParityX == 1 { // Original count is odd, so 1 (odd) for x is OK
			newOkOdd = max(newOkOdd, 1)
		} else { // Original count is even, so 1 (odd) for x is NOT OK
			newNotOkOdd = max(newNotOkOdd, 1)
		}

		// Option 2: Extend a subsequence ending with u < x. x's count becomes 1 (odd).
		maxPrevOk := max(prevOkEven, prevOkOdd)
		maxPrevNotOk := max(prevNotOkEven, prevNotOkOdd)

		if maxPrevOk > 0 { // Can extend an "ok" previous subsequence
			if targetParityX == 1 { // x as odd count is OK
				newOkOdd = max(newOkOdd, maxPrevOk+1)
			} else { // x as odd count is NOT OK
				newNotOkOdd = max(newNotOkOdd, maxPrevOk+1)
			}
		}
		if maxPrevNotOk > 0 { // Can extend a "not ok" previous subsequence (still not ok)
			newNotOkOdd = max(newNotOkOdd, maxPrevNotOk+1)
		}

		// Option 3: Extend a subsequence ending with x itself.
		// From curr_ok_odd (x was odd, all previous ok) -> x becomes even.
		if currOkOdd > 0 {
			if targetParityX == 0 { // x as even count is OK
				newOkEven = max(newOkEven, currOkOdd+1)
			} else { // x as even count is NOT OK
				newNotOkEven = max(newNotOkEven, currOkOdd+1)
			}
		}
		// From curr_ok_even (x was even, all previous ok) -> x becomes odd.
		if currOkEven > 0 {
			if targetParityX == 1 { // x as odd count is OK
				newOkOdd = max(newOkOdd, currOkEven+1)
			} else { // x as odd count is NOT OK
				newNotOkOdd = max(newNotOkOdd, currOkEven+1)
			}
		}
		// From curr_not_ok_odd (x was odd, some previous not ok) -> x becomes even. Still not ok.
		if currNotOkOdd > 0 {
			newNotOkEven = max(newNotOkEven, currNotOkOdd+1)
		}
		// From curr_not_ok_even (x was even, some previous not ok) -> x becomes odd. Still not ok.
		if currNotOkEven > 0 {
			newNotOkOdd = max(newNotOkOdd, currNotOkEven+1)
		}

		// Update the segment tree at rankX with the new maximums.
		// We take max with current values to ensure we don't lose previous best LNDS ending at x.
		st.update(rankX,
			max(currOkEven, newOkEven),
			max(currOkOdd, newOkOdd),
			max(currNotOkEven, newNotOkEven),
			max(currNotOkOdd, newNotOkOdd),
		)
	}

	// After processing all numbers, query the entire range to get the overall max length
	finalRes := st.query(1, maxRank)
	maxLen := max(finalRes.okEven, finalRes.okOdd) // Only consider "ok" subsequences

	// The number of elements to remove is N - maxLen.
	// Since each removed element must be part of a pair, the number of pairs is (N - maxLen) / 2.
	return (n - maxLen) / 2
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}