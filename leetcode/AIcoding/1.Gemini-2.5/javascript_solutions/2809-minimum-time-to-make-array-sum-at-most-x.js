var minimumTime = function(nums1, nums2, x) {
    const n = nums1.length;

    // Create pairs [nums1[i], nums2[i]]
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push([nums1[i], nums2[i]]);
    }

    // Sort pairs based on nums2[i] in ascending order
    pairs.sort((a, b) => a[1] - b[1]);

    // dp[j] will store the maximum sum of (nums1[s'_m] + m * nums2[s'_m])
    // where s'_m are j chosen items, sorted by nums2 ascending, and m is their rank (1 to j).
    // This represents the maximum "reduction value" if j items are chosen.
    // Initialize dp array. dp[0] = 0 (no items chosen, no reduction).
    // Other dp[j] are initialized to a very small number (negative infinity)
    // because we are looking for a maximum.
    const dp = new Array(n + 1).fill(0);
    // Use BigInt for dp values to prevent overflow if sums get very large, though for this problem
    // standard numbers might be enough as max sum is 10^3 * (10^9 + 10^3 * 10^9) which is 10^15.
    // JavaScript numbers (doubles) can precisely represent integers up to 2^53 - 1 (approx 9 * 10^15).
    // So, standard numbers should be fine.

    // Iterate through each item
    for (let i = 0; i < n; i++) {
        const [n1, n2] = pairs[i];
        // Iterate j from current number of items processed down to 1
        // This is a 0/1 knapsack-like DP, so we iterate backwards to ensure
        // each item is considered at most once for a given j.
        for (let j = i; j >= 0; j--) {
            // If we choose the current item as the (j+1)-th item (in terms of count)
            // The value it contributes is n1 + (j+1) * n2.
            // This is added to the max reduction from choosing j items before it.
            dp[j + 1] = Math.max(dp[j + 1], dp[j] + n1 + (j + 1) * n2);
        }
    }

    // Calculate initial total sum of nums1 and nums2
    let initialSum1 = 0;
    let initialSum2 = 0;
    for (let i = 0; i < n; i++) {
        initialSum1 += nums1[i];
        initialSum2 += nums2[i];
    }

    // Iterate through possible number of operations k (from 0 to n)
    // to find the minimum k that satisfies the condition.
    for (let k = 0; k <= n; k++) {
        // The total sum after k operations is calculated as:
        // (Initial sum of nums1) + (k * Initial sum of nums2) - (Maximum reduction achieved by choosing k items)
        // The dp[k] value represents sum(nums1[s'_m] + m * nums2[s'_m]) for chosen items.
        // The formula for the final sum is:
        // sum(nums1[all]) + k * sum(nums2[all]) - sum(nums1[chosen] + (k - rank_desc + 1) * nums2[chosen])
        // where rank_desc is rank in descending nums2 order.
        // This is equivalent to:
        // sum(nums1[all]) + k * sum(nums2[all]) - (sum(nums1[chosen]) + (k+1)*sum(nums2[chosen]) - sum(m*nums2[chosen]))
        // where m is rank in ascending nums2 order.
        // The dp[k] value already stores sum(nums1[chosen] + m*nums2[chosen]).
        // So the term to subtract from sum(nums1[all]) + k * sum(nums2[all]) is dp[k].
        // This is a common transformation for this type of problem.
        const currentTotalSum = initialSum1 + k * initialSum2 - dp[k];

        if (currentTotalSum <= x) {
            return k;
        }
    }

    // If no k satisfies the condition, return n (or -1 if problem implies no solution possible,
    // but usually it's n or n+1 for this type of problem).
    // The problem states "it's guaranteed that a solution always exists".
    // So the loop will always find a solution.
    // In the worst case, if we remove all items (k=n), sum is 0, which is <= x.
    return n; // Should not reach here if a solution always exists and loop covers all k.
};