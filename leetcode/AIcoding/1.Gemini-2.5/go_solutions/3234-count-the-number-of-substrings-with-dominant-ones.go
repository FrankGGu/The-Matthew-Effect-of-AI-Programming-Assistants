package main

type FenwickTree struct {
	tree []int
	size int
}

func NewFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		tree: make([]int, size+1), // 1-based indexing for tree array
		size: size,                // Max 0-based index
	}
}

func (ft *FenwickTree) Update(idx int, val int) {
	idx++ // Convert to 1-based index
	for idx <= ft.size {
		ft.tree[idx] += val
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) Query(idx int) int {
	idx++ // Convert to 1-based index
	sum := 0
	for idx > 0 {
		sum += ft.tree[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func numberOfSubstrings(s string, k int) int64 {
	n := len(s)

	// Calculate prefix sums where '1' contributes +1 and '0' contributes -1.
	// prefixSum[p] stores the sum for s[0...p-1].
	// prefixSum[0] is 0 (empty prefix sum).
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		val := -1
		if s[i] == '1' {
			val = 1
		}
		prefixSum[i+1] = prefixSum[i] + val
	}

	// The prefix sums can range from -n (all '0's) to n (all '1's).
	// To use them as indices in a Fenwick tree, we need to shift them to be non-negative.
	// We shift by 'n', so the range [-n, n] maps to [0, 2n].
	// The Fenwick tree needs to support indices up to 2n.
	// So, its size (max 0-based index) should be 2n.
	bitMaxIdx := 2 * n
	ft := NewFenwickTree(bitMaxIdx)

	var ans int64 = 0

	// Initialize the Fenwick tree by adding the frequency of prefixSum[0].
	// prefixSum[0] is 0. Shifted value is 0 + n = n.
	ft.Update(0+n, 1)

	// Iterate through the string, considering each character s[j] as the right endpoint
	// of a potential substring.
	for j := 0; j < n; j++ {
		// We are looking for an index 'i' (0 <= i <= j) such that the substring s[i...j]
		// satisfies the condition.
		// The condition is: countOnes(i, j) >= countZeros(i, j) + k
		// This can be rewritten as: (countOnes(i, j) - countZeros(i, j)) >= k
		// Using prefix sums: prefixSum[j+1] - prefixSum[i] >= k
		// Rearranging to find prefixSum[i]: prefixSum[i] <= prefixSum[j+1] - k

		targetVal := prefixSum[j+1] - k

		// Shift the target value to match the Fenwick tree's shifted indices.
		shiftedTargetVal := targetVal + n

		// Query the Fenwick tree to count how many valid prefixSum[i] values
		// (for i from 0 to j) satisfy the condition.
		// The query index must be within the valid range [0, 2n].
		queryIdx := shiftedTargetVal
		if queryIdx < 0 {
			queryIdx = -1 // If target is below min possible shifted value, no elements satisfy.
		}
		if queryIdx > bitMaxIdx {
			queryIdx = bitMaxIdx // If target is above max possible shifted value, all elements satisfy.
		}

		ans += int64(ft.Query(queryIdx))

		// Add the current prefixSum[j+1] to the Fenwick tree for future iterations.
		// Shifted value: prefixSum[j+1] + n.
		ft.Update(prefixSum[j+1]+n, 1)
	}

	return ans
}