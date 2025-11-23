function longestArithSeqSubseq(nums, k) {
    const n = nums.length;
    if (n < 2) return 1;

    const dp = new Array(n).fill(0).map(() => new Map());
    let maxLen = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = nums[i] - nums[j];
            const count = dp[j].get(diff) || 1;
            dp[i].set(diff, count + 1);
            maxLen = Math.max(maxLen, count + 1);
        }
    }

    return maxLen;
}