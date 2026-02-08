package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

type TrieNode struct {
	children [2]*TrieNode
	maxIdx   int // max index 'k' such that prefixXor[k] passes through this node
}

func newTrieNode() *TrieNode {
	return &TrieNode{maxIdx: -1} // Initialize with -1 for invalid index
}

func (t *TrieNode) Insert(val, idx int, maxBits int) {
	curr := t
	curr.maxIdx = max(curr.maxIdx, idx) // Update root's maxIdx
	for i := maxBits - 1; i >= 0; i-- {
		bit := (val >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = newTrieNode()
		}
		curr = curr.children[bit]
		curr.maxIdx = max(curr.maxIdx, idx) // Update child's maxIdx
	}
}

func (t *TrieNode) Query(target, minIdx int, maxBits int) int {
	curr := t
	res := 0
	for i := maxBits - 1; i >= 0; i-- {
		// If current node or any path through it doesn't have an index >= minIdx,
		// it means no valid number can be formed from this point.
		// This should not happen if a valid number P[k] with k >= minIdx exists in the Trie
		// and passes through the current prefix path.
		// Given problem constraints, a valid subarray always exists for a valid query range.
		// Thus, a P[i] with i >= minIdx will always be found.
		// So, curr.maxIdx >= minIdx should always hold true if curr is not nil.
		if curr == nil || curr.maxIdx < minIdx {
			break
		}

		bit := (target >> i) & 1
		oppositeBit := 1 - bit

		// Try to go the opposite way to maximize XOR
		if curr.children[oppositeBit] != nil && curr.children[oppositeBit].maxIdx >= minIdx {
			res |= (1 << i)
			curr = curr.children[oppositeBit]
		} else {
			// Must take the same way (or opposite path is invalid/not present)
			// This path must be valid if curr.maxIdx >= minIdx
			curr = curr.children[bit]
		}
	}
	return res
}

type Query struct {
	L, R, idx int
}

func maxXorSubarrayQueries(nums []int, queries [][]int) []int {
	N := len(nums)
	prefixXor := make([]int, N+1)
	for i := 0; i < N; i++ {
		prefixXor[i+1] = prefixXor[i] ^ nums[i]
	}

	// Group queries by their right endpoint (second)
	// queriesAtR[k] will store queries (L, original_idx) where R = k
	queriesAtR := make([][]Query, N)
	for qIdx, q := range queries {
		L, R := q[0], q[1]
		queriesAtR[R] = append(queriesAtR[R], Query{L: L, R: R, idx: qIdx})
	}

	ans := make([]int, len(queries))
	root := newTrieNode()
	maxBits := 30 // Max value of nums[i] is 10^9, which fits in 30 bits (2^29 < 10^9 < 2^30)

	// Insert prefixXor[0] (which is 0) at index 0 into the Trie
	root.Insert(prefixXor[0], 0, maxBits)

	// Iterate 'j' from 0 to N-1 (this is the 'second' index of the subarray)
	for j := 0; j < N; j++ {
		// Process all queries whose right endpoint 'R' is 'j'
		for _, q := range queriesAtR[j] {
			// For a query [first, second], we need max(P[j+1] ^ P[i]) for first <= i <= j.
			// Here, q.R is 'j', so P[j+1] is prefixXor[q.R+1].
			// The minimum index for P[i] is q.L.
			ans[q.idx] = root.Query(prefixXor[q.R+1], q.L, maxBits)
		}
		// Insert prefixXor[j+1] at index j+1 into the Trie for future queries.
		// This makes prefixXor[0]...prefixXor[j+1] available for the next iteration (j+1).
		root.Insert(prefixXor[j+1], j+1, maxBits)
	}

	return ans
}