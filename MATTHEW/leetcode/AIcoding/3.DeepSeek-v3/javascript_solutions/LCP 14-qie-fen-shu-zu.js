var splitArray = function(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(Infinity);
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        left[i] = i === 0 ? nums[i] : left[i - 1] | nums[i];
    }

    for (let i = n - 1; i >= 0; i--) {
        right[i] = i === n - 1 ? nums[i] : nums[i] | right[i + 1];
    }

    dp[0] = left[0] + (n > 1 ? right[1] : 0);

    for (let i = 1; i < n; i++) {
        for (let j = 0; j <= i; j++) {
            const leftOr = j === 0 ? left[i] : left[i] ^ left[j - 1];
            const rightOr = i === n - 1 ? 0 : right[i + 1];
            const current = (j === 0 ? 0 : dp[j - 1]) + leftOr + rightOr;
            if (current < dp[i]) {
                dp[i] = current;
            }
        }
    }

    return dp[n - 1];
};