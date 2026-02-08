function maxJump(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    const deque = [];

    for (let i = 0; i < n; i++) {
        while (deque.length > 0 && deque[0] < i - k) {
            deque.shift();
        }

        dp[i] = nums[i] + (deque.length > 0 ? dp[deque[0]] : 0);

        while (deque.length > 0 && dp[i] >= dp[deque[deque.length - 1]]) {
            deque.pop();
        }

        deque.push(i);
    }

    return dp[n - 1];
}