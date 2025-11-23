import (
	"math"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func makeTheXorOfAllSegmentsEqualToZero(nums []int, k int) int {
	n := len(nums)

	// MAX_XOR_VAL is 2^10 = 1024, since nums[i] <= 1000.
	// This covers all possible XOR sums up to 1023.
	const MAX_XOR_VAL = 1 << 10

	// dp[j] stores the minimum operations to make the XOR sum of processed columns equal to j.
	dp := make([]int, MAX_XOR_VAL)
	for i := 1; i < MAX_XOR_VAL; i++ {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for colIdx := 0; colIdx < k; colIdx++ {
		freq := make(map[int]int)
		count := 0
		X_orig := 0 // Original XOR sum of the current column

		// Populate frequency map and calculate original XOR sum for the current column
		for j := colIdx; j < n; j += k {
			freq[nums[j]]++
			count++
			X_orig ^= nums[j]
		}

		nextDp := make([]int, MAX_XOR_VAL)
		for i := 0; i < MAX_XOR_VAL; i++ {
			nextDp[i] = math.MaxInt32
		}

		// Calculate min_prev_ops: minimum operations to achieve any XOR sum from previous columns
		minPrevOps := math.MaxInt32
		for _, ops := range dp {
			minPrevOps = min(minPrevOps, ops)
		}

		// Case 1: Keep the original XOR sum of the current column (cost 0 for this column)
		// This applies if count > 0. If count == 0, X_orig is 0 and cost is 0, which doesn't change dp.
		for prevXOR := 0; prevXOR < MAX_XOR_VAL; prevXOR++ {
			if dp[prevXOR] == math.MaxInt32 {
				continue
			}
			// The new total XOR sum will be prevXOR ^ X_orig
			nextDp[prevXOR^X_orig] = min(nextDp[prevXOR^X_orig], dp[prevXOR])
		}

		// Case 2: Change `count - 1` elements in the current column (cost `count - 1` for this column)
		// This is possible if `count > 0`. We keep one element `v` from the column and change `count - 1` others.
		// The `count - 1` elements can be changed to XOR to `target_XOR_for_current_column ^ v`.
		// So, if we choose to keep an element `v` from `freq`, the new total XOR sum will be `prevXOR ^ v`.
		if count > 0 {
			for prevXOR := 0; prevXOR < MAX_XOR_VAL; prevXOR++ {
				if dp[prevXOR] == math.MaxInt32 {
					continue
				}
				for val := range freq { // Iterate over unique values in current column
					// Cost for current column is `count - 1` (keep one `val`, change others)
					nextDp[prevXOR^val] = min(nextDp[prevXOR^val], dp[prevXOR]+(count-1))
				}
			}
		}

		// Case 3: Change all `count` elements in the current column (cost `count` for this column)
		// This allows the current column to have any XOR sum.
		// This means we can achieve any `target_xor` for the combined columns by paying `minPrevOps` for previous columns
		// and `count` for the current column.
		if minPrevOps != math.MaxInt32 { // Only apply if previous states were reachable
			for j := 0; j < MAX_XOR_VAL; j++ {
				nextDp[j] = min(nextDp[j], minPrevOps+count)
			}
		}

		dp = nextDp
	}

	return dp[0]
}