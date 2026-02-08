var longestArithmeticSubsequence = function(nums) {
    const n = nums.length;

    const dp = Array(n).fill(0).map(() => new Map());

    let maxLength = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = nums[i] - nums[j];

            const lengthAtJ = dp[j].get(diff) || 1;

            const currentLength = lengthAtJ + 1;

            dp[i].set(diff, Math.max(dp[i].get(diff) || 0, currentLength));

            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};