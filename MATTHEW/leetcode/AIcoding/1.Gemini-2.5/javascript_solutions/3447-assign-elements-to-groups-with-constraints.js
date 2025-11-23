var assignElementsToGroups = function(nums, constraints) {
    const n = nums.length;

    // maxGroupForIdx[i] stores the maximum allowed group number for index i.
    // Initialize with n for all indices, then apply constraints.
    const maxGroupForIdx = new Array(n).fill(n);
    for (const [idx, val] of constraints) {
        maxGroupForIdx[idx] = Math.min(maxGroupForIdx[idx], val);
    }

    // dp[j] stores the maximum sum ending at group j for the current element.
    // Using a large negative number for unreachable states.
    const NEG_INF = -Infinity;

    let dp = new Array(n + 1).fill(NEG_INF); // dp array is 1-indexed for groups

    // Base case: For the first element (nums[0]), it can be assigned to any group j
    // from 1 to maxGroupForIdx[0]. The sum is just nums[0].
    for (let j = 1; j <= maxGroupForIdx[0]; j++) {
        dp[j] = nums[0];
    }

    // Iterate through the elements from the second one (index 1) to the last.
    for (let i = 1; i < n; i++) {
        const next_dp = new Array(n + 1).fill(NEG_INF);
        const deque = []; // Stores indices k of dp array, in decreasing order of dp[k] values.

        // This loop computes the maximum of dp[k] for k in [j-1, j+1] for all j.
        // It iterates k from 1 to n+1 to ensure all relevant windows are covered.
        // When k is j_to_compute + 1, the window [j_to_compute - 1, j_to_compute + 1] is complete.
        for (let k = 1; k <= n + 1; k++) {
            // Get dp[k] value, treating out-of-bounds as NEG_INF.
            const val_k = (k >= 1 && k <= n) ? dp[k] : NEG_INF;

            // Maintain deque such that dp[deque[idx]] is in decreasing order.
            // Remove elements from the back of the deque that are smaller than or equal to val_k.
            if (val_k !== NEG_INF) {
                while (deque.length > 0 && dp[deque[deque.length - 1]] <= val_k) {
                    deque.pop();
                }
                deque.push(k);
            }

            // Calculate next_dp[j_to_compute] when the window for it is complete.
            // The window for next_dp[j_to_compute] is [j_to_compute - 1, j_to_compute + 1].
            // This window is complete when k reaches j_to_compute + 1.
            const j_to_compute = k - 1;

            if (j_to_compute >= 1 && j_to_compute <= n) {
                // Remove elements from the front of the deque that are outside the current window.
                // The leftmost boundary for j_to_compute's window is max(1, j_to_compute - 1).
                while (deque.length > 0 && deque[0] < Math.max(1, j_to_compute - 1)) {
                    deque.shift();
                }

                // If the deque is not empty, its front element is the index of the maximum value
                // in dp for the window [j_to_compute - 1, j_to_compute + 1].
                if (deque.length > 0) {
                    const max_prev_dp = dp[deque[0]];

                    // If a valid previous path exists and the current group is allowed by constraints.
                    if (j_to_compute <= maxGroupForIdx[i] && max_prev_dp !== NEG_INF) {
                        next_dp[j_to_compute] = nums[i] + max_prev_dp;
                    }
                }
            }
        }
        dp = next_dp; // Update dp for the next iteration
    }

    // The final answer is the maximum value in the last dp array.
    let maxSum = NEG_INF;
    for (let j = 1; j <= n; j++) {
        maxSum = Math.max(maxSum, dp[j]);
    }

    // If maxSum is still NEG_INF, it means no valid assignment was found.
    // The problem asks for the maximum possible sum. If no path, it implies -1.
    return maxSum === NEG_INF ? -1 : maxSum;
};