function minChanges(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const count = new Map();

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        let current = 0;
        for (let j = i; j >= 0; j--) {
            current ^= nums[j];
            if (j === 0) {
                dp[i] = 1;
            } else {
                dp[i] = Math.min(dp[i], dp[j - 1] + 1);
            }
            count.set(current, (count.get(current) || 0) + 1);
        }
    }

    return dp[n - 1];
}