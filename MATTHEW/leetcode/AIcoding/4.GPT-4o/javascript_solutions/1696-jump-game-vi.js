var maxResult = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    dp[0] = nums[0];
    const deque = [];
    deque.push(0);

    for (let i = 1; i < n; i++) {
        while (deque.length && deque[0] < i - k) {
            deque.shift();
        }
        dp[i] = nums[i] + dp[deque[0]];
        while (deque.length && dp[deque[deque.length - 1]] <= dp[i]) {
            deque.pop();
        }
        deque.push(i);
    }

    return dp[n - 1];
};