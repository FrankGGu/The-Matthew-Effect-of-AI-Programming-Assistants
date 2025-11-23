var stoneGameVIII = function(stones) {
    const n = stones.length;

    // Calculate suffix sums
    // Suffix sum S[i] = stones[i] + ... + stones[n-1]
    // S[n] = 0 (for an empty suffix)
    const suffixSum = new Array(n + 1).fill(0);
    for (let i = n - 1; i >= 0; i--) {
        suffixSum[i] = stones[i] + suffixSum[i + 1];
    }

    // dp[i] represents the maximum score difference Alice can achieve
    // if the game starts with stones[i...n-1] and it's Alice's turn.
    // We need to find dp[0].
    // dp[n] = 0 (no stones left, score difference is 0)
    //
    // The recurrence relation is:
    // dp[i] = max_{1 <= x <= n-i} ( (sum of stones[i...i+x-1]) - dp[i+x] )
    // The sum of stones[i...i+x-1] is suffixSum[i] - suffixSum[i+x].
    // So, dp[i] = max_{1 <= x <= n-i} ( (suffixSum[i] - suffixSum[i+x]) - dp[i+x] )
    // dp[i] = suffixSum[i] - min_{1 <= x <= n-i} ( suffixSum[i+x] + dp[i+x] )
    // Let j = i+x. Then x ranges from 1 to n-i, so j ranges from i+1 to n.
    // dp[i] = suffixSum[i] - min_{j = i+1 ... n} ( suffixSum[j] + dp[j] )

    // Initialize dp array. dp[n] is the base case.
    const dp = new Array(n + 1);
    dp[n] = 0;

    // min_f_suffix will store min_{k = i+1 ... n} (suffixSum[k] + dp[k])
    // For i = n-1, we need min_{k = n} (suffixSum[k] + dp[k]), which is (suffixSum[n] + dp[n]).
    // So, min_f_suffix is initialized with suffixSum[n] + dp[n].
    let min_f_suffix_val = suffixSum[n] + dp[n]; // This is 0 + 0 = 0

    // Iterate from n-1 down to 0
    for (let i = n - 1; i >= 0; i--) {
        // Calculate dp[i] using the current minimum from the suffix
        dp[i] = suffixSum[i] - min_f_suffix_val;

        // Update min_f_suffix_val for the next iteration (i-1)
        // The value for f[i] = suffixSum[i] + dp[i] becomes a candidate for the minimum.
        min_f_suffix_val = Math.min(min_f_suffix_val, suffixSum[i] + dp[i]);
    }

    return dp[0];
};