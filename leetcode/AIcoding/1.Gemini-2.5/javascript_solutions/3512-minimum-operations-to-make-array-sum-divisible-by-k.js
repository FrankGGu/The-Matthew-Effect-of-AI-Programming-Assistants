var minOperations = function(nums, k) {
    let totalSumRemainder = 0;
    for (const num of nums) {
        totalSumRemainder = (totalSumRemainder + num) % k;
    }

    // If the total sum is already divisible by k, no operations are needed.
    if (totalSumRemainder === 0) {
        return 0;
    }

    // We need to find a subset of 'nums' whose sum modulo k is 'totalSumRemainder'.
    // The goal is to minimize the number of elements in this subset.
    // This is a variation of the subset sum problem, where we track minimum count
    // to achieve a certain remainder.

    // dp[r] will store the minimum number of elements needed to achieve a sum
    // with remainder 'r' when divided by 'k'.
    // Initialize dp array with Infinity for all remainders, except dp[0] = 0
    // (0 elements sum to 0 with remainder 0).
    const dp = new Array(k).fill(Infinity);
    dp[0] = 0;

    for (const num of nums) {
        const num_rem = num % k;
        // Iterate dp array from k-1 down to 0.
        // This ensures that each 'num' is considered only once for forming new sums
        // in the current iteration, preventing using the same 'num' multiple times
        // within a single subset being built.
        for (let r = k - 1; r >= 0; r--) {
            if (dp[r] !== Infinity) {
                const new_rem = (r + num_rem) % k;
                dp[new_rem] = Math.min(dp[new_rem], dp[r] + 1);
            }
        }
    }

    // The minimum number of operations required is the minimum count of elements
    // that sum to 'totalSumRemainder' modulo 'k'.
    // If dp[totalSumRemainder] is Infinity, it means no subset can achieve this remainder.
    // However, based on typical problem constraints, a solution should always exist.
    // (e.g., by removing all elements, the sum is 0, which is divisible by k.
    // This implies that if totalSumRemainder is not 0, there must be a way to form it
    // with a non-empty subset of elements.)
    return dp[totalSumRemainder];
};