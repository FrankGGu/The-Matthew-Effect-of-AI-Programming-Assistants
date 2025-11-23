var findMaximumLength = function(nums) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    const dp = new Array(n + 1).fill(0);
    const last = new Array(n + 1).fill(0);
    const queue = [];
    queue.push(0);

    for (let i = 1; i <= n; i++) {
        while (queue.length >= 2 && prefix[queue[1]] + last[queue[1]] <= prefix[i]) {
            queue.shift();
        }
        const j = queue[0];
        dp[i] = dp[j] + 1;
        last[i] = prefix[i] - prefix[j];

        while (queue.length > 0 && prefix[i] + last[i] <= prefix[queue[queue.length - 1]] + last[queue[queue.length - 1]]) {
            queue.pop();
        }
        queue.push(i);
    }

    return dp[n];
};