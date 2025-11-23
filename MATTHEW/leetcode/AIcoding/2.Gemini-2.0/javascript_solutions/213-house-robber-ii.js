var rob = function(nums) {
    const n = nums.length;
    if (n === 0) return 0;
    if (n === 1) return nums[0];

    function helper(arr) {
        const len = arr.length;
        if (len === 0) return 0;
        if (len === 1) return arr[0];

        const dp = new Array(len);
        dp[0] = arr[0];
        dp[1] = Math.max(arr[0], arr[1]);

        for (let i = 2; i < len; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + arr[i]);
        }

        return dp[len - 1];
    }

    return Math.max(helper(nums.slice(0, n - 1)), helper(nums.slice(1)));
};