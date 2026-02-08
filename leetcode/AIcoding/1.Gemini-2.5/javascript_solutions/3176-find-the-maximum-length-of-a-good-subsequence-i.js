var findTheMaximumLength = function(nums, k) {
    // dp[mask][sum] stores the maximum length of a good subsequence
    // ending with a number whose bitmask is 'mask' and the total sum is 'sum'.
    // Numbers are up to 1000, which requires 10 bits (2^10 = 1024).
    const MAX_MASK = 1024; // Represents masks from 0 to 1023.

    // Initialize dp table with 0s.
    // dp[mask] will be an array of size (k+1), where each element stores a length.
    // A value of 0 means no such subsequence has been found yet.
    const dp = Array(MAX_MASK).fill(0).map(() => Array(k + 1).fill(0));

    let maxOverallLength = 0;

    // Iterate through each number in the input array.
    for (const num of nums) {
        const val = num;
        const mask = num;

        // If the current number alone exceeds k, it cannot be part of any valid subsequence.
        if (val > k) {
            continue;
        }

        // Create a temporary array to store updates for the current 'mask' based on 'val'.
        // This is crucial to avoid using the current 'num' multiple times
        // within the same subsequence or using 'num' to extend a subsequence
        // that already implicitly includes 'num' from this same iteration.
        const currentUpdates = Array(k + 1).fill(0);

        // Case 1: Start a new good subsequence with 'val'.
        // The subsequence is just [val], which has length 1 and sum 'val'.
        currentUpdates[val] = 1;

        // Case 2: Extend existing good subsequences with 'val'.
        // Iterate over all possible previous masks.
        for (let prevMask = 0; prevMask < MAX_MASK; prevMask++) {
            // Check if the bitwise AND condition is met: prevMask & mask must be 0.
            if ((prevMask & mask) === 0) {
                // Iterate over all possible previous sums.
                // The new sum will be prevSum + val.
                // So, prevSum can go up to k - val to ensure newSum does not exceed k.
                for (let prevSum = 0; prevSum <= k - val; prevSum++) {
                    // If a good subsequence ending with 'prevMask' and sum 'prevSum' exists (length > 0):
                    if (dp[prevMask][prevSum] > 0) {
                        const newSum = prevSum + val;
                        const newLength = dp[prevMask][prevSum] + 1;

                        // Update the maximum length for this new sum for the current mask.
                        currentUpdates[newSum] = Math.max(currentUpdates[newSum], newLength);
                    }
                }
            }
        }

        // After processing all possible extensions for the current 'num',
        // update the main dp table for 'mask' with the best lengths found.
        for (let sum = 0; sum <= k; sum++) {
            dp[mask][sum] = Math.max(dp[mask][sum], currentUpdates[sum]);
            // Keep track of the maximum length found so far across all masks and sums.
            maxOverallLength = Math.max(maxOverallLength, dp[mask][sum]);
        }
    }

    return maxOverallLength;
};