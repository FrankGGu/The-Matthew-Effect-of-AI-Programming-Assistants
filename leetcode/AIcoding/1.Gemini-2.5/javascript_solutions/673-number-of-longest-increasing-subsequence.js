var findNumberOfLIS = function(nums) {
    const n = nums.length;
    if (n === 0) {
        return 0;
    }

    const dp = new Array(n).fill(1);
    const count = new Array(n).fill(1);

    let maxLength = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    count[i] = count[j];
                } else if (dp[j] + 1 === dp[i]) {
                    count[i] += count[j];
                }
            }
        }
        maxLength = Math.max(maxLength, dp[i]);
    }

    let totalCount = 0;
    for (let i = 0; i < n; i++) {
        if (dp[i] === maxLength) {
            totalCount += count[i];
        }
    }

    return totalCount;
};