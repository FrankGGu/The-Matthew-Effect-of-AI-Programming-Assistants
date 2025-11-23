var maxSumTwoNoOverlap = function(nums, firstLen, secondLen) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    // Helper function to get sum of subarray nums[start...end]
    const getSum = (start, end) => {
        if (start < 0 || end >= n || start > end) return 0; // Should not happen with correct indexing
        return prefixSum[end + 1] - prefixSum[start];
    };

    // This function calculates the maximum sum where the subarray of length L
    // appears before the subarray of length M.
    const solve = (L, M) => {
        let maxL_so_far = 0; // Max sum of an L-length subarray ending at or before index (i - M)
        let ans = 0;

        // Iterate through all possible ending positions for the M-length subarray
        // The M-length subarray ends at index `i`.
        // The L-length subarray must end at or before index `i - M`.
        for (let i = L + M - 1; i < n; i++) {
            // Calculate the sum of the L-length subarray that ends at index (i - M)
            // This subarray is nums[i - M - L + 1 ... i - M]
            const current_L_sum_at_i_minus_M = getSum(i - M - L + 1, i - M);

            // Update maxL_so_far to be the maximum sum of any L-length subarray
            // that could be placed before the current M-length subarray.
            maxL_so_far = Math.max(maxL_so_far, current_L_sum_at_i_minus_M);

            // Calculate the sum of the M-length subarray that ends at index i
            // This subarray is nums[i - M + 1 ... i]
            const current_M_sum_at_i = getSum(i - M + 1, i);

            // Update the overall answer
            ans = Math.max(ans, maxL_so_far + current_M_sum_at_i);
        }
        return ans;
    };

    // The maximum sum can be either (firstLen subarray before secondLen subarray)
    // or (secondLen subarray before firstLen subarray).
    return Math.max(solve(firstLen, secondLen), solve(secondLen, firstLen));
};