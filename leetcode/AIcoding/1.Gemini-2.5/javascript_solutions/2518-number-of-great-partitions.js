var countGreatPartitions = function(nums, k) {
    const MOD = 10**9 + 7;
    const n = nums.length;

    let totalSum = 0;
    for (const num of nums) {
        totalSum += num;
    }

    if (totalSum < 2 * k) {
        return 0;
    }

    // dp[i] will store the number of subsets that sum to i.
    // We only need to track sums strictly less than k.
    // The maximum sum we need to store in dp is k-1.
    // So dp array size is k.
    const dp = new Array(k).fill(0);
    dp[0] = 1; // One way to get sum 0 (empty set)

    for (const num of nums) {
        // Iterate backwards to avoid using the current num multiple times in one subset.
        // We only update dp[i] for sums 'i' that are strictly less than k.
        for (let i = k - 1; i >= num; i--) {
            dp[i] = (dp[i] + dp[i - num]) % MOD;
        }
    }

    let countLessThanK = 0;
    for (let i = 0; i < k; i++) {
        countLessThanK = (countLessThanK + dp[i]) % MOD;
    }

    // Total number of subsets is 2^n.
    let totalSubsets = 1;
    for (let i = 0; i < n; i++) {
        totalSubsets = (totalSubsets * 2) % MOD;
    }

    // We want partitions where sum(P1) >= k AND sum(P2) >= k.
    // This is equivalent to totalSubsets - (count(sum(P1) < k) + count(sum(P2) < k)).
    // Since totalSum >= 2k, the conditions sum(P1) < k and sum(P2) < k are mutually exclusive.
    // count(sum(P1) < k) is countLessThanK.
    // count(sum(P2) < k) means sum(P1) > totalSum - k.
    // Due to symmetry, the number of subsets with sum < k is equal to
    // the number of subsets whose complement has sum < k (i.e., sum > totalSum - k).
    // So, count(sum(P1) > totalSum - k) is also countLessThanK.
    // Therefore, the number of "bad" subsets is 2 * countLessThanK.

    // Need to add MOD multiple times to handle potential negative results from subtraction.
    let result = (totalSubsets - 2 * countLessThanK % MOD + MOD + MOD) % MOD;

    return result;
};