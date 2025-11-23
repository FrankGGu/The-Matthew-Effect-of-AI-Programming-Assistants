var totalSteps = function(nums) {
    let n = nums.length;
    let stack = [];
    let dp = new Array(n).fill(0);
    let ans = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[i] > nums[stack[stack.length - 1]]) {
            dp[i] = Math.max(dp[i] + 1, dp[stack[stack.length - 1]]);
            stack.pop();
        }
        stack.push(i);
        ans = Math.max(ans, dp[i]);
    }

    return ans;
};