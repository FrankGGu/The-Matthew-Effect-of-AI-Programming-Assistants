var constrainedSubsetSum = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const deque = [];
    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        if (deque.length > 0 && i - deque[0] > k) {
            deque.shift();
        }

        dp[i] = nums[i] + (deque.length > 0 ? dp[deque[0]] : 0);
        dp[i] = Math.max(dp[i], nums[i]);

        while (deque.length > 0 && dp[i] >= dp[deque[deque.length - 1]]) {
            deque.pop();
        }

        if (dp[i] > 0) {
            deque.push(i);
        }

        maxSum = Math.max(maxSum, dp[i]);
    }

    return maxSum;
};