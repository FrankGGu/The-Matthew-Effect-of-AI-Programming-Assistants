var sumOfKSubarraysWithLengthAtLeastM = function(nums, k, m) {
    const n = nums.length;

    if (k * m > n) {
        return -1;
    }

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let dp_prev = new Array(n + 1).fill(-Infinity);
    dp_prev[0] = 0;

    for (let j = 1; j <= k; j++) {
        let dp_curr = new Array(n + 1).fill(-Infinity);
        let max_prev_sum_minus_prefix = -Infinity;

        for (let i = 1; i <= n; i++) {
            // Option 1: nums[i-1] is not part of the j-th subarray
            dp_curr[i] = dp_curr[i-1];

            // Check if it's possible to form j subarrays up to index i-1
            if (i >= j * m) {
                // Update max_prev_sum_minus_prefix for the current window ending at i-m.
                // This considers dp_prev[s] - prefixSum[s] where s = i-m.
                // dp_prev[i-m] is the max sum of (j-1) subarrays using elements up to index (i-m)-1.
                if (dp_prev[i-m] !== -Infinity) {
                    max_prev_sum_minus_prefix = Math.max(max_prev_sum_minus_prefix, dp_prev[i-m] - prefixSum[i-m]);
                }

                // Option 2: nums[i-1] is the end of the j-th subarray.
                // This subarray ends at i-1 and has length at least m.
                // Its sum is prefixSum[i] - prefixSum[s], where s is its start index.
                // We want to maximize (dp_prev[s] + (prefixSum[i] - prefixSum[s]))
                // which simplifies to prefixSum[i] + (dp_prev[s] - prefixSum[s]).
                // max_prev_sum_minus_prefix holds the maximum of (dp_prev[s] - prefixSum[s])
                // for all valid s such that (j-1)*m <= s <= i-m.
                if (max_prev_sum_minus_prefix !== -Infinity) {
                    dp_curr[i] = Math.max(dp_curr[i], max_prev_sum_minus_prefix + prefixSum[i]);
                }
            }
        }
        dp_prev = dp_curr;
    }

    return dp_prev[n] === -Infinity ? -1 : dp_prev[n];
};