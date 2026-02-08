var findMaximumLength = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const sum = new Array(n).fill(0);
    sum[0] = nums[0];
    dp[0] = 1;
    let ans = 1;
    for (let i = 1; i < n; i++) {
        sum[i] = sum[i - 1] + nums[i];
        let l = 0, r = i - 1;
        let idx = -1;
        while (l <= r) {
            const mid = Math.floor((l + r) / 2);
            if (sum[mid] >= nums[i]) {
                idx = mid;
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }
        if (idx === -1) {
            dp[i] = 1;
        } else {
            if (idx === 0) {
                dp[i] = 2;
            } else {
                dp[i] = dp[idx - 1] + 2;
            }
        }
        dp[i] = Math.max(dp[i], dp[i - 1]);
        ans = Math.max(ans, dp[i]);
    }
    return ans;
};