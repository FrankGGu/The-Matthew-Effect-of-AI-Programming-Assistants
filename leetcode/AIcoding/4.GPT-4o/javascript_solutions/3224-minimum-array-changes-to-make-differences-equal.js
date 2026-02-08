var minChanges = function(nums, k) {
    const n = nums.length;
    const count = Array.from({ length: k }, () => new Map());

    for (let i = 0; i < n; i++) {
        const mod = nums[i] % k;
        count[i % k].set(mod, (count[i % k].get(mod) || 0) + 1);
    }

    const dp = Array.from({ length: k }, () => new Array(102).fill(0));

    for (let i = 0; i < k; i++) {
        let total = 0;
        let maxFreq = 0;

        for (let [value, freq] of count[i]) {
            total += freq;
            maxFreq = Math.max(maxFreq, freq);
        }

        dp[i][0] = total - maxFreq; // Change all except the most frequent
        for (let j = 1; j < 102; j++) {
            dp[i][j] = dp[i][0];
        }
    }

    let result = 0;
    for (let j = 0; j < k; j++) {
        result += dp[j][0];
    }

    return result;
};