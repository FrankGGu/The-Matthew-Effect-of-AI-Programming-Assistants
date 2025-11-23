var maxRotateFunction = function(nums) {
    const n = nums.length;
    if (n === 0) {
        return 0;
    }

    let sum = 0;
    let currentF = 0;

    for (let i = 0; i < n; i++) {
        sum += nums[i];
        currentF += i * nums[i];
    }

    let maxF = currentF;

    for (let k = 1; k < n; k++) {
        // F(k) = F(k-1) + sum - n * nums[n-k]
        // The element that moves from coefficient (n-1) to 0 is nums[n-k].
        // So, F(k) = F(k-1) - (n-1)*nums[n-k] + (sum - nums[n-k])
        // F(k) = F(k-1) + sum - n*nums[n-k]
        // Or, using the derived relation F(k+1) = F(k) + n*A[k] - S
        // For the current iteration, currentF is F(k-1) and nums[k-1] is A[k-1].
        // To get F(k) from F(k-1):
        // F(k) = F(k-1) + sum_of_all_elements - n * element_that_was_at_index_0_in_F(k-1)
        // No, the recurrence is F(k+1) = F(k) + S - n * A[n-1-k] (element that was last)
        // Let's re-derive for F(k) from F(k-1) using the previous derivation F(k+1) = F(k) + n*A[k] - S.
        // If currentF is F(k-1), then the next F is F(k).
        // F(k) = F(k-1) + n * A[k-1] - S
        // Here, A[k-1] is the element that was at index 0 in the (k-1)-th rotation.
        // Which is nums[n - (k-1)] in the original array. No, this is confusing.

        // Let's stick to the derivation: F(k+1) = F(k) + n*A[k] - S
        // Here, A[k] is the element that was at index 0 in the *original* array for the k-th rotation.
        // No, A[k] is the element that was at index `k` in the *original* array.
        // The relation is F(next_rotation) = F(current_rotation) + sum - n * last_element_of_previous_rotation_in_original_array_index.
        // F(k) from F(k-1):
        // F(k) = F(k-1) + sum - n * nums[n - k]
        // This is the correct recurrence. nums[n-k] is the element that "falls off" the end and wraps around to the beginning with coefficient 0.

        currentF = currentF + sum - n * nums[n - k];
        maxF = Math.max(maxF, currentF);
    }

    return maxF;
};