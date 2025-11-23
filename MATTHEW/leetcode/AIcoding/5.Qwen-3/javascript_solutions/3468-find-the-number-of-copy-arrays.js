function numberOfCopyArrays(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const freq = new Map();

    for (let i = 0; i < n; i++) {
        if (freq.has(nums[i])) {
            dp[i] = dp[freq.get(nums[i]) - 1] + 1;
        } else {
            dp[i] = 1;
        }
        freq.set(nums[i], i + 1);
    }

    return dp.reduce((a, b) => a + b, 0);
}