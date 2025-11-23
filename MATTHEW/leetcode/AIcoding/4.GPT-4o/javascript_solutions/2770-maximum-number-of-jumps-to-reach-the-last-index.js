var maxJumps = function(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && nums[stack[stack.length - 1]] < nums[i]) {
            dp[i] = Math.max(dp[i], dp[stack.pop()] + 1);
        }
        stack.push(i);
    }

    return Math.max(...dp);
};