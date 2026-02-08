var maxResult = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n);
    const deque = []; // Stores indices

    dp[0] = nums[0];
    deque.push(0);

    for (let i = 1; i < n; i++) {
        while (deque.length > 0 && deque[0] < i - k) {
            deque.shift();
        }

        dp[i] = nums[i] + dp[deque[0]];

        while (deque.length > 0 && dp[deque[deque.length - 1]] <= dp[i]) {
            deque.pop();
        }

        deque.push(i);
    }

    return dp[n - 1];
};