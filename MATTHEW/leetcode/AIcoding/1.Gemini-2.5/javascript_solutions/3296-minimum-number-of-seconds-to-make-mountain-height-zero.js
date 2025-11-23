var minimumSeconds = function(heights) {
    const n = heights.length;

    // max_left_boundary[i] stores the maximum effective height at index i, derived from a mountain j < i.
    // Specifically, it's max(heights[j] + (i - j)) for 0 <= j < i.
    // If no such j exists (i.e., for i=0), it's initialized to Number.MIN_SAFE_INTEGER.
    const max_left_boundary = new Array(n).fill(Number.MIN_SAFE_INTEGER);
    let current_max_h_minus_idx = Number.MIN_SAFE_INTEGER; // Stores max(heights[j] - j) for j < i

    for (let i = 0; i < n; i++) {
        if (i > 0) {
            // Update current_max_h_minus_idx using the previous mountain (heights[i-1])
            current_max_h_minus_idx = Math.max(current_max_h_minus_idx, heights[i-1] - (i-1));
        }
        // Calculate max_left_boundary[i] = max(heights[j] - j) + i.
        // If current_max_h_minus_idx is still Number.MIN_SAFE_INTEGER, it means no left mountains exist,
        // so max_left_boundary[i] should remain Number.MIN_SAFE_INTEGER.
        if (current_max_h_minus_idx !== Number.MIN_SAFE_INTEGER) {
            max_left_boundary[i] = current_max_h_minus_idx + i;
        }
    }

    // max_right_boundary[i] stores the maximum effective height at index i, derived from a mountain j > i.
    // Specifically, it's max(heights[j] + (j - i)) for i < j < n.
    // If no such j exists (i.e., for i=n-1), it's initialized to Number.MIN_SAFE_INTEGER.
    const max_right_boundary = new Array(n).fill(Number.MIN_SAFE_INTEGER);
    let current_max_h_plus_idx = Number.MIN_SAFE_INTEGER; // Stores max(heights[j] + j) for j > i

    for (let i = n - 1; i >= 0; i--) {
        if (i < n - 1) {
            // Update current_max_h_plus_idx using the next mountain (heights[i+1])
            current_max_h_plus_idx = Math.max(current_max_h_plus_idx, heights[i+1] + (i+1));
        }
        // Calculate max_right_boundary[i] = max(heights[j] + j) - i.
        // If current_max_h_plus_idx is still Number.MIN_SAFE_INTEGER, it means no right mountains exist,
        // so max_right_boundary[i] should remain Number.MIN_SAFE_INTEGER.
        if (current_max_h_plus_idx !== Number.MIN_SAFE_INTEGER) {
            max_right_boundary[i] = current_max_h_plus_idx - i;
        }
    }

    let max_chosen_reductions = 0;

    for (let i = 0; i < n; i++) {
        let num_free_reductions = 0;

        // A mountain can only be a peak if it's strictly greater than *both* its neighbors.
        // If either max_left_boundary[i] or max_right_boundary[i] is Number.MIN_SAFE_INTEGER, it means
        // a neighbor is missing, so it cannot satisfy the "strictly greater than both" condition.
        if (max_left_boundary[i] !== Number.MIN_SAFE_INTEGER && max_right_boundary[i] !== Number.MIN_SAFE_INTEGER) {
            // The number of "free" peak reductions is limited by how much heights[i] exceeds
            // the maximum effective height from its left and right neighbors.
            // If heights[i] is less than or equal to max(max_left_boundary[i], max_right_boundary[i]),
            // it means it's not strictly higher than both effective neighbors, so it gets 0 free reductions.
            // Otherwise, the difference is the number of times it can be a peak.
            num_free_reductions = Math.max(0, heights[i] - Math.max(max_left_boundary[i], max_right_boundary[i]));
        }

        // The number of "chosen" reductions needed for mountain i is its total height minus free reductions.
        const num_chosen_reductions = heights[i] - num_free_reductions;

        // The overall minimum time is the maximum number of chosen reductions needed for any single mountain.
        max_chosen_reductions = Math.max(max_chosen_reductions, num_chosen_reductions);
    }

    return max_chosen_reductions;
};