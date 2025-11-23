package main

type FenwickTree struct {
	size int
	tree []int
}

func NewFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		size: size,
		tree: make([]int, size+1), // 1-indexed
	}
}

func (ft *FenwickTree) Update(idx, delta int) {
	idx++ // Convert to 1-indexed
	for idx <= ft.size {
		ft.tree[idx] += delta
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) Query(idx int) int {
	if idx < 0 { // Handle queries for indices before the start
		return 0
	}
	idx++ // Convert to 1-indexed
	sum := 0
	for idx > 0 {
		sum += ft.tree[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func isTransformable(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	// Step 1: Check character counts
	sCounts := make([]int, 10)
	tCounts := make([]int, 10)
	for i := 0; i < len(s); i++ {
		sCounts[s[i]-'0']++
		tCounts[t[i]-'0']++
	}
	for i := 0; i < 10; i++ {
		if sCounts[i] != tCounts[i] {
			return false
		}
	}

	// Step 2: Initialize queues for original indices of each digit in s
	// q[digit] stores a list of indices where 'digit' appears in s, in increasing order
	q := make([][]int, 10)
	for i, char := range s {
		digit := char - '0'
		q[digit] = append(q[digit], i)
	}

	// Step 3: Initialize Fenwick trees for each digit
	// bits[digit] tracks the presence of 'digit' at its original indices in s
	bits := make([]*FenwickTree, 10)
	for d := 0; d < 10; d++ {
		bits[d] = NewFenwickTree(len(s))
	}
	for i, char := range s {
		digit := char - '0'
		bits[digit].Update(i, 1) // Mark digit at index i as available
	}

	// Step 4: Process t from left to right
	for j := 0; j < len(t); j++ {
		targetDigit := t[j] - '0'

		// Get the next available original index of targetDigit from s
		// This is guaranteed to exist because we checked counts in Step 1
		srcIdx := q[targetDigit][0]
		q[targetDigit] = q[targetDigit][1:] // Remove the used index

		// Check if any smaller digit is blocking targetDigit from moving left
		// targetDigit (from srcIdx) needs to conceptually move to position j.
		// It can only move left past other digits X if targetDigit <= X.
		// This means it cannot move left past any digit X if targetDigit > X.
		// We need to check if there are any available digits 'd' (where d < targetDigit)
		// at an original index 'p' such that p < srcIdx.
		for d := 0; d < targetDigit; d++ {
			// Query the Fenwick tree for digit 'd' to count how many 'd's are
			// still available at positions before srcIdx.
			if bits[d].Query(srcIdx-1) > 0 {
				return false // A smaller digit is blocking it
			}
		}

		// Mark targetDigit at srcIdx as used in its Fenwick tree
		bits[targetDigit].Update(srcIdx, -1)
	}

	// If the loop completes, it means all characters in t could be formed
	return true
}