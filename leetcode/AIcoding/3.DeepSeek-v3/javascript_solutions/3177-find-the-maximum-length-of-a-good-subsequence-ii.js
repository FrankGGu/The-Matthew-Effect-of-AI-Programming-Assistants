var maximumLength = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));
    const maxLen = new Array(k + 1).fill(0);
    const maxNum = new Map();

    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= k; j++) {
            let current = 1;
            if (maxNum.has(nums[i])) {
                const [prevMax, prevK] = maxNum.get(nums[i]);
                current = Math.max(current, prevMax + 1);
            }
            if (j > 0) {
                current = Math.max(current, maxLen[j - 1] + 1);
            }
            dp[i][j] = current;
        }

        for (let j = 0; j <= k; j++) {
            if (!maxNum.has(nums[i]) || dp[i][j] > maxNum.get(nums[i])[0]) {
                maxNum.set(nums[i], [dp[i][j], j]);
            }
            if (dp[i][j] > maxLen[j]) {
                maxLen[j] = dp[i][j];
            }
        }
    }

    return maxLen[k];
};