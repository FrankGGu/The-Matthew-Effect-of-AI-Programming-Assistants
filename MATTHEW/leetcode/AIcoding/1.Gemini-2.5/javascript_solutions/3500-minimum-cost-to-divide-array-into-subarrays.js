var minCost = function(nums, k) {
    const n = nums.length;

    // Precompute costs[l][r] for all subarrays nums[l...r]
    // cost = (r - l + 1) + trim(nums[l...r])
    // trim(arr) is the number of elements that appear at least twice
    const costs = Array(n).fill(0).map(() => Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        const freq = new Map();
        let currentTrim = 0;
        for (let j = i; j < n; j++) {
            const num = nums[j];
            freq.set(num, (freq.get(num) || 0) + 1);
            if (freq.get(num) === 2) {
                currentTrim++;
            }
            costs[i][j] = (j - i + 1) + currentTrim;
        }
    }

    // dp[i] will store min cost to divide nums[0...i-1] into `j` subarrays
    // prev_dp[i] will store min cost to divide nums[0...i-1] into `j-1` subarrays
    let prev_dp = Array(n + 1).fill(Infinity);
    prev_dp[0] = 0; // Cost to divide empty prefix into 0 subarrays is 0

    for (let j = 1; j <= k; j++) { // j is the number of subarrays
        let current_dp = Array(n + 1).fill(Infinity);

        // Define the recursive function for Divide and Conquer Optimization
        // compute(i_start, i_end, p_start, p_end)
        // computes current_dp[i] for i in [i_start, i_end]
        // using optimal split points p in [p_start, p_end]
        const compute = (i_start, i_end, p_start, p_end) => {
            if (i_start > i_end) return;

            const i_mid = Math.floor((i_start + i_end) / 2);
            let best_p = -1; // Stores the optimal split point for i_mid

            // The split point p represents the start index of the last subarray (nums[p...i_mid-1]).
            // The prefix nums[0...p-1] is divided into j-1 subarrays.
            // So, p-1 must be at least j-1-1 = j-2, which means p >= j-1.
            // Also, the last subarray must contain at least one element, so p <= i_mid-1.
            const actual_p_start = Math.max(p_start, j - 1);
            const actual_p_end = Math.min(p_end, i_mid - 1);

            for (let p = actual_p_start; p <= actual_p_end; p++) {
                if (prev_dp[p] === Infinity) continue;

                // Cost of the last subarray nums[p...i_mid-1]
                const segmentCost = costs[p][i_mid - 1];
                const total_cost = prev_dp[p] + segmentCost;

                if (total_cost < current_dp[i_mid]) {
                    current_dp[i_mid] = total_cost;
                    best_p = p;
                }
            }

            // Recursively compute for left and right halves.
            // The optimal split point for i < i_mid is <= best_p.
            // The optimal split point for i > i_mid is >= best_p.
            compute(i_start, i_mid - 1, p_start, best_p);
            compute(i_mid + 1, i_end, best_p, p_end);
        };

        // Initial call for compute:
        // i ranges from j to n (inclusive)
        // p ranges from j-1 to n-1 (inclusive, as p can be up to n-1 for i=n)
        compute(j, n, j - 1, n - 1);
        prev_dp = current_dp;
    }

    return prev_dp[n];
};