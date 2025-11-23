var constrainedSubsetSum = function(nums, k) {
    const n = nums.length;
    const dp = Array(n).fill(0);
    const deque = [];

    for (let i = 0; i < n; i++) {
        dp[i] = nums[i] + (deque.length > 0 ? Math.max(0, dp[deque[0]]) : 0);

        while (deque.length && dp[deque[deque.length - 1]] <= dp[i]) {
            deque.pop();
        }

        deque.push(i);

        if (deque[0] === i - k) {
            deque.shift();
        }
    }

    return Math.max(...dp);
};