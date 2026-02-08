class Solution {
    public boolean checkArray(int[] nums, int k) {
        int n = nums.length;
        // delta[i] stores the number of times we apply the operation starting at index i.
        // This array helps to track the effect of operations in O(1) per index.
        // Using long to prevent overflow as nums[i] can be up to 10^9.
        long[] delta = new long[n]; 

        // current_decrement_from_previous_ops tracks the total decrement applied to the current index 'i'
        // by operations that started at indices 'p' such that 'i-k < p < i'.
        // Using long to prevent overflow as sum can be k * max_nums_i (10^5 * 10^9 = 10^14).
        long current_decrement_from_previous_ops = 0;

        for (int i = 0; i < n; i++) {
            // If i >= k, the operation that started at i-k is no longer active at index i.
            // So, subtract its contribution from the current_decrement_from_previous_ops.
            if (i >= k) {
                current_decrement_from_previous_ops -= delta[i - k];
            }

            // Calculate the effective value of nums[i] after all relevant previous operations.
            long effective_val_at_i = nums[i] - current_decrement_from_previous_ops;

            // If the effective value is negative, it's impossible to make it zero,
            // because we can only decrement values.
            if (effective_val_at_i < 0) {
                return false;
            }

            // If the effective value is positive, we must apply an operation starting at 'i'
            // exactly 'effective_val_at_i' times to make nums[i] zero.
            if (effective_val_at_i > 0) {
                // If applying this operation would extend beyond the array, it's impossible.
                // An operation starting at 'i' affects elements up to 'i + k - 1'.
                // If 'i + k - 1' is out of bounds (i.e., 'i + k > n'), then it's invalid.
                if (i + k > n) {
                    return false;
                }
                delta[i] = effective_val_at_i;
                current_decrement_from_previous_ops += delta[i];
            }
            // If effective_val_at_i is 0, delta[i] remains 0, and current_decrement_from_previous_ops doesn't change.
        }

        // After iterating through all indices, current_decrement_from_previous_ops
        // should be zero. If it's not, it means there are still active operations
        // that would affect elements beyond the array's boundary (indices n to n+k-2),
        // which implies an invalid state.
        if (current_decrement_from_previous_ops != 0) {
            return false;
        }

        return true;
    }
}