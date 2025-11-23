int minKBitFlips(int* nums, int numsSize, int k) {
    int n = numsSize;
    int flips = 0;
    int current_flips_in_window = 0; // Tracks the number of active flips affecting the current element

    // We use the `nums` array itself to store whether a flip operation started at index `i`.
    // If `nums[i]` is modified to be >= 2, it means a flip operation started at `i`.
    // The original value of `nums[i]` can be retrieved by `nums[i] % 2`.
    // This approach allows O(1) extra space.

    for (int i = 0; i < n; ++i) {
        // If a flip operation started `k` positions ago (at `i - k`), its effect
        // on the current element `nums[i]` has ended.
        // We check if `nums[i - k]` was marked as a start of a flip (value >= 2).
        if (i >= k && nums[i - k] >= 2) {
            current_flips_in_window--;
        }

        // Determine the current effective state of `nums[i]`.
        // The effective value is `(original_nums[i] + current_flips_in_window) % 2`.
        // The original `nums[i]` value is `nums[i] % 2`.
        // The goal is to make all elements equal to 1.
        // If the current effective state is 0, we need to perform a flip starting at `i`.
        if (((nums[i] % 2) + current_flips_in_window) % 2 == 0) {
            // We must perform an operation starting at `i`.
            // Check if performing this operation would go out of bounds.
            // The last element affected would be `i + k - 1`. This must be less than `n`.
            if (i + k > n) {
                return -1; // Impossible to make all elements 1
            }
            flips++;
            current_flips_in_window++;
            // Mark that a flip started at `i` by adding 2 to `nums[i]`.
            // This changes `0` to `2` and `1` to `3`.
            // `nums[i] % 2` will still correctly give the original bit value.
            nums[i] += 2;
        }
    }

    return flips;
}