import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func findMaximumSequenceValue(nums []int) int {
	n := len(nums)
	if n < 3 {
		return 0
	}

	// max_i_val: Stores the maximum value of nums[x] encountered so far (for x <= current_idx).
	// This helps in calculating max(nums[x] - nums[y]) efficiently.
	max_i_val := nums[0]

	// max_i_minus_j_val: Stores the maximum value of (nums[x] - nums[y]) encountered so far
	// where x < y <= current_idx.
	// This helps in calculating max((nums[x] - nums[y]) * nums[z]) efficiently.
	max_i_minus_j_val := math.MinInt64

	// max_product_val: Stores the maximum sequence value (nums[i] - nums[j]) * nums[k]
	// where 0 <= i < j < k <= current_idx.
	// Initialized to 0 as per problem statement (return 0 if no such sequence exists,
	// and products can be negative).
	max_product_val := 0

	// Iterate 'current_idx' from 1 to n-1.
	// 'current_idx' acts as 'k' in the expression (nums[i] - nums[j]) * nums[k].
	for current_idx := 1; current_idx < n; current_idx++ {
		// Step 1: Calculate potential product for current_idx (acting as 'k').
		// We need max(nums[i] - nums[j]) for i < j < current_idx.
		// The 'max_i_minus_j_val' at this point stores max(nums[x] - nums[y]) for x < y <= current_idx-1.
		// This is exactly what we need for (nums[i] - nums[j]) where j < k (current_idx).
		// A valid (i, j, k) triplet requires k >= 2.
		if current_idx >= 2 {
			current_product := max_i_minus_j_val * nums[current_idx]
			max_product_val = max(max_product_val, current_product)
		}

		// Step 2: Update max_i_minus_j_val for the next iteration.
		// We want max(nums[x] - nums[y]) for x < y <= current_idx.
		// This is max of:
		//   1. Previous max_i_minus_j_val (which covers x < y <= current_idx-1)
		//   2. max(nums[x] - nums[current_idx]) for x < current_idx.
		//      max(nums[x]) for x < current_idx is stored in max_i_val (before its update in Step 3).
		max_i_minus_j_val = max(max_i_minus_j_val, max_i_val - nums[current_idx])

		// Step 3: Update max_i_val for the next iteration.
		// We want max(nums[x]) for x <= current_idx.
		max_i_val = max(max_i_val, nums[current_idx])
	}

	return max_product_val
}