var maxSubarraySumCircular = function(nums, k) {
    const n = nums.length;
    let maxSum = -Infinity;
    let prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let deque = [];
    for (let i = 0; i <= n; i++) {
        while (deque.length && (i - deque[0]) > k) {
            deque.shift();
        }
        if (deque.length) {
            maxSum = Math.max(maxSum, prefixSum[i] - prefixSum[deque[0]]);
        }
        while (deque.length && prefixSum[i] <= prefixSum[deque[deque.length - 1]]) {
            deque.pop();
        }
        deque.push(i);
    }

    return maxSum === -Infinity ? 0 : maxSum;
};