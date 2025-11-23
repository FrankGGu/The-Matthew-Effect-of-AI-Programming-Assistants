var minCost = function(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(0);
    const freq = new Array(100001).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = Infinity;
        let uniqueCount = 0;

        for (let j = i; j > 0; j--) {
            if (freq[nums[j - 1]] === 0) uniqueCount++;
            freq[nums[j - 1]]++;
            dp[i] = Math.min(dp[i], dp[j - 1] + k + uniqueCount - 1);
        }

        for (let j = i; j > 0; j--) {
            freq[nums[j - 1]]--;
            if (freq[nums[j - 1]] === 0) uniqueCount--;
        }
    }

    return dp[n];
};