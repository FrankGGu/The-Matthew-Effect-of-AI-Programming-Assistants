var longestArithSeqLength = function(nums) {
    const n = nums.length;
    if (n <= 2) return n;

    const dp = new Array(n);
    for (let i = 0; i < n; i++) {
        dp[i] = new Map();
    }

    let maxLen = 2;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = nums[i] - nums[j];
            const prevLen = dp[j].get(diff) || 1;
            dp[i].set(diff, prevLen + 1);
            maxLen = Math.max(maxLen, dp[i].get(diff));
        }
    }

    return maxLen;
};