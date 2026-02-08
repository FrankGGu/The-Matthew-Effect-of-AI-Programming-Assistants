function constrainedSubsequenceSum(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const deque = [];

    for (let i = 0; i < n; i++) {
        dp[i] = nums[i];
        if (deque.length > 0) {
            dp[i] += dp[deque[0]];
        }

        while (deque.length > 0 && dp[i] >= dp[deque[deque.length - 1]]) {
            deque.pop();
        }

        deque.push(i);

        if (deque[0] <= i - k) {
            deque.shift();
        }
    }

    return Math.max(...dp);
}