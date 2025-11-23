var longestUnequalAdjacentGroupsSubsequence = function(nums, groups) {
    const n = nums.length;
    const m = groups.length;
    const dp = Array(m).fill(0);

    for (let i = 0; i < n; i++) {
        for (let j = m - 1; j >= 0; j--) {
            if (groups[j] !== nums[i]) {
                if (j === 0) {
                    dp[j] = Math.max(dp[j], 1);
                } else {
                    dp[j] = Math.max(dp[j], dp[j - 1] + 1);
                }
            }
        }
        if (groups[0] !== nums[i]) {
          dp[0] = Math.max(dp[0], 1);
        }
    }

    let maxLen = 0;
    for (let i = 0; i < m; i++) {
        maxLen = Math.max(maxLen, dp[i]);
    }

    return maxLen;
};