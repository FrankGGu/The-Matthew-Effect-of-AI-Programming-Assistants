var numberOfArithmeticSlices = function(nums) {
    const n = nums.length;
    if (n < 3) {
        return 0;
    }

    let totalCount = 0;
    // dp[i] is a Map where keys are common differences and values are the counts
    // of arithmetic subsequences of length at least 2, ending at index i, with that difference.
    const dp = new Array(n).fill(0).map(() => new Map());

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            // Use BigInt for difference calculation to prevent potential overflow
            // if nums[i] and nums[j] are large and their difference exceeds Number.MAX_SAFE_INTEGER,
            // though for typical LeetCode constraints, Number should be fine for diff.
            // However, using BigInt ensures correctness for any integer range.
            // Convert back to Number for map key if necessary, or ensure map handles BigInt keys.
            // JavaScript Map keys can be any type, so BigInt keys are fine.
            const diff = BigInt(nums[i]) - BigInt(nums[j]);

            // Number of arithmetic subsequences of length >= 2 ending at j with this diff
            const countJDiff = dp[j].get(diff) || 0;

            // Current count of arithmetic subsequences of length >= 2 ending at i with this diff
            const currentCountIDiff = dp[i].get(diff) || 0;

            // Update dp[i]:
            // 1. Add 1 for the new subsequence of length 2: (nums[j], nums[i])
            // 2. Add countJDiff for subsequences of length >= 3 formed by extending
            //    subsequences ending at j with this diff by appending nums[i].
            dp[i].set(diff, currentCountIDiff + 1 + countJDiff);

            // Add to totalCount:
            // Each countJDiff represents an arithmetic subsequence of length >= 2 ending at j.
            // When we append nums[i] to these, they become arithmetic subsequences of length >= 3.
            // These are the ones we need to count for the final answer.
            totalCount += countJDiff;
        }
    }

    return totalCount;
};