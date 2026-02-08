var maxActiveSection = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    // max_overall stores the maximum sum found across all subarrays
    let max_overall = -Infinity;

    // current_no_flip stores the maximum sum of a subarray ending at the current position,
    // without having used the "trade" operation yet.
    let current_no_flip = 0;

    // current_with_flip stores the maximum sum of a subarray ending at the current position,
    // having used exactly one "trade" operation.
    let current_with_flip = 0;

    for (let i = 0; i < nums.length; i++) {
        let n = nums[i];

        // Store the value of current_no_flip before it's updated for the current element.
        // This is crucial because it's used to calculate the option of flipping 'n'
        // and adding it to a previously non-flipped subarray.
        let prev_current_no_flip = current_no_flip;

        // Update current_no_flip:
        // Either start a new subarray with 'n', or extend the previous non-flipped subarray.
        current_no_flip = Math.max(n, current_no_flip + n);

        // Update current_with_flip:
        // There are three ways to get a max sum ending at 'i' with one flip:
        // 1. Extend a subarray that already used its flip: current_with_flip + n
        // 2. Extend a subarray that *had not* used its flip (prev_current_no_flip), and use the flip on current 'n': prev_current_no_flip + Math.abs(n)
        // 3. Start a new subarray by using the flip on current 'n': Math.abs(n)
        current_with_flip = Math.max(
            current_with_flip + n,
            prev_current_no_flip + Math.abs(n),
            Math.abs(n)
        );

        // Update the overall maximum sum found so far.
        // It could be from a subarray that didn't use a flip, or one that did.
        max_overall = Math.max(max_overall, current_no_flip, current_with_flip);
    }

    return max_overall;
};