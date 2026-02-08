var numberOfUniqueGoodSubsequences = function(s) {
    const MOD = 10**9 + 7;

    // dp0: number of unique subsequences ending with '0' that start with '1'
    // dp1: number of unique subsequences ending with '1' that start with '1'
    let dp0 = 0;
    let dp1 = 0;

    // A flag to track if '0' has been seen in the string.
    // This is used for the special case where the string might consist only of '0's.
    // If '0' is the only character, and we don't have a '1', then the result is 0.
    // If the string contains '1' and '0', and the string ends with '0', we might need to count '0' as a good subsequence.
    // No, the problem states "starts with '1' and ends with '1'".
    // So, if the string is "0", "00", "010", the result should be 0, 0, 1 respectively.
    // My current DP states already handle this implicitly.
    // The `+1` for `dp1` when '1' is encountered is for the single subsequence "1".
    // `dp0` will only get non-zero values if `dp1` is non-zero, meaning a '1' has been encountered.
    // So, `hasZero` is not needed for the core logic, but it's needed to handle the edge case
    // where the string contains '0's but no '1's, and we need to return 0.
    // However, if the string is "0", "00", "000", `dp1` will remain 0, which is correct.
    // If the string is "010", `dp1` will be 1, which is correct.
    // The only edge case is if the string contains at least one '0' AND no '1's, then the answer is 0.
    // If the string contains at least one '0' AND at least one '1', and it ends with '0', we can still have good subsequences.
    // The problem is about unique good subsequences.
    // If the string is "0", the answer is 0.
    // If the string is "00", the answer is 0.
    // If the string is "1", the answer is 1.
    // If the string is "10", the answer is 1. ("1")
    // If the string is "01", the answer is 1. ("1")
    // If the string is "101", the answer is 3. ("1", "11", "101")

    // The logic below correctly computes `dp1` for all cases.
    // The only special handling is for the case where the string contains at least one '0',
    // but no '1's. In such a scenario, `dp1` would be 0, which is correct.
    // However, if the string is "0", and we return `dp1`, it's 0.
    // If the string is "01", `dp1` is 1.
    // If the string is "000", `dp1` is 0.
    // This seems correct without any extra `hasZero` flag.

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === '0') {
            // To form a unique subsequence ending with '0' (starting with '1'):
            // 1. Append '0' to existing unique subsequences ending with '0' (dp0).
            // 2. Append '0' to existing unique subsequences ending with '1' (dp1).
            // These two sets of new subsequences are disjoint and unique.
            dp0 = (dp0 + dp1) % MOD;
        } else { // char === '1'
            // To form a unique subsequence ending with '1' (starting with '1'):
            // 1. Append '1' to existing unique subsequences ending with '0' (dp0).
            // 2. Append '1' to existing unique subsequences ending with '1' (dp1).
            // 3. The single character subsequence "1" itself.
            // These three sets are disjoint and unique.
            // The `+1` accounts for the new subsequence "1" formed from an empty string.
            dp1 = (dp0 + dp1 + 1) % MOD;
        }
    }

    // The problem asks for unique good subsequences, which are those starting with '1' and ending with '1'.
    // Our `dp1` variable directly tracks this.
    return dp1;
};