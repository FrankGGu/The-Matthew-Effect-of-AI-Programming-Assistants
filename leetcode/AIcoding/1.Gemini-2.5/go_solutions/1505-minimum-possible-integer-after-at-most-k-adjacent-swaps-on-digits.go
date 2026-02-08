package main

import (
	"math"
	"strconv"
)

type FenwickTree struct {
	data []int
	size int
}

func newFenwickTree(n int) *FenwickTree {
	ft := &FenwickTree{
		data: make([]int, n+1), // 1-indexed
		size: n,
	}
	// Initialize all elements to 1
	for i := 1; i <= n; i++ {
		ft.update(i, 1)
	}
	return ft
}

func (ft *FenwickTree) update(idx, val int) {
	for idx <= ft.size {
		ft.data[idx] += val
		idx += idx & (-idx) // Move to parent
	}
}

func (ft *FenwickTree) query(idx int) int {
	sum := 0
	for idx > 0 {
		sum += ft.data[idx]
		idx -= idx & (-idx) // Move to parent
	}
	return sum
}

func minInteger(num string, k int) string {
	n := len(num)
	if n == 0 {
		return ""
	}

	// Queues to store original indices of each digit.
	// pos[d] will store a list of original 0-indexed positions where digit 'd' appears.
	pos := make([][]int, 10)
	for i := 0; i < n; i++ {
		digit := num[i] - '0'
		pos[digit] = append(pos[digit], i)
	}

	// Fenwick tree to track available positions and calculate swaps needed.
	// It's 1-indexed, so we use originalIdx + 1 for BIT operations.
	ft := newFenwickTree(n)

	// Result string builder
	result := make([]byte, 0, n)
	// used array to track which original indices have been placed in the result.
	// This helps in appending remaining characters efficiently.
	used := make([]bool, n)

	// Iterate through each target position `i` in the result string.
	for i := 0; i < n; i++ {
		// If no more swaps are allowed, break and append remaining characters.
		if k == 0 {
			break
		}

		bestDigit := -1
		bestOriginalIdx := -1
		minSwaps := math.MaxInt32 // Initialize with a value greater than any possible swaps

		// Try to find the smallest digit (0-9) that can be moved to position `i`.
		for digit := 0; digit <= 9; digit++ {
			// If no more occurrences of this digit are available, skip.
			if len(pos[digit]) == 0 {
				continue
			}

			originalIdx := pos[digit][0] // Peek the first (leftmost) available occurrence of this digit.

			// Calculate swaps needed to move num[originalIdx] to target position `i`.
			// `ft.query(originalIdx + 1)` gives the count of available elements from original index 0 up to `originalIdx`.
			// This count is effectively the 1-indexed current position of `num[originalIdx]` if all available elements to its left were shifted.
			// So, `ft.query(originalIdx + 1) - 1` is its 0-indexed current effective position.
			// `i` is the target 0-indexed position.
			// Swaps needed = (current effective position) - (target position).
			swapsNeeded := ft.query(originalIdx+1) - 1 - i

			// If we have enough swaps for this digit
			if swapsNeeded <= k {
				// If this digit requires fewer swaps, it's a better candidate.
				if swapsNeeded < minSwaps {
					minSwaps = swapsNeeded
					bestDigit = digit
					bestOriginalIdx = originalIdx
				}
				// If swaps needed are equal, we prioritize the smaller digit (lexicographical order).
				// This is implicitly handled because we iterate `digit` from 0 to 9.
				// The first digit we find with `swapsNeeded <= k` and `swapsNeeded == minSwaps` will naturally be the smallest `digit`.
			}
		}

		// If a best digit was found (which should always be the case if k > 0 and i < n, as min swaps can be 0)
		if bestDigit != -1 {
			result = append(result, byte('0'+bestDigit)) // Append the chosen digit to the result.
			k -= minSwaps                                // Deduct swaps used from k.
			ft.update(bestOriginalIdx+1, -1)             // Mark this position as unavailable in the Fenwick tree.
			pos[bestDigit] = pos[bestDigit][1:]          // Dequeue the used index from its digit's queue.
			used[bestOriginalIdx] = true                 // Mark the original index as used.
		} else {
			// This case should theoretically not be reached if k > 0 and i < n,
			// because there will always be at least one digit that can be moved (with 0 swaps if it's already in place).
			// If it is reached, it implies no digit can be moved within the remaining k swaps,
			// meaning the remaining part is already "optimal" relative to current k.
			// So, we break and append the rest.
			break
		}
	}

	// After the loop, if k became 0 or no more moves were possible,
	// append any remaining unused characters from the original string in their original relative order.
	for j := 0; j < n; j++ {
		if !used[j] {
			result = append(result, num[j])
		}
	}

	return string(result)
}