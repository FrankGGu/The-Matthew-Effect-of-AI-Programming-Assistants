var maximumLength = function(nums, k) {
    const n = nums.length;
    const dp = Array.from({ length: n }, () => new Array(k + 1).fill(1));
    const maxLen = Array.from({ length: k + 1 }, () => ({}));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= k; j++) {
            const num = nums[i];
            if (maxLen[j][num] !== undefined) {
                dp[i][j] = Math.max(dp[i][j], maxLen[j][num] + 1);
            }
            if (j > 0) {
                for (const key in maxLen[j - 1]) {
                    if (key !== num.toString()) {
                        dp[i][j] = Math.max(dp[i][j], maxLen[j - 1][key] + 1);
                    }
                }
            }
        }
        for (let j = 0; j <= k; j++) {
            const num = nums[i];
            if (maxLen[j][num] === undefined || dp[i][j] > maxLen[j][num]) {
                maxLen[j][num] = dp[i][j];
            }
        }
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= k; j++) {
            result = Math.max(result, dp[i][j]);
        }
    }
    return result;
};