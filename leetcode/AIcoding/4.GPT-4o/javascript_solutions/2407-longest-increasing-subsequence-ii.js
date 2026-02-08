var lengthOfLIS = function(nums) {
    const n = nums.length;
    if (n === 0) return 0;

    const dp = Array(n).fill(1);
    let maxLength = 1;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
        maxLength = Math.max(maxLength, dp[i]);
    }

    return maxLength;
};