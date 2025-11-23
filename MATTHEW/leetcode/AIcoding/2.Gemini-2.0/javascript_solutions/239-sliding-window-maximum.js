var maxSlidingWindow = function(nums, k) {
    const n = nums.length;
    const result = [];
    const deque = [];

    for (let i = 0; i < n; i++) {
        while (deque.length > 0 && nums[deque[deque.length - 1]] <= nums[i]) {
            deque.pop();
        }
        deque.push(i);

        if (deque[0] <= i - k) {
            deque.shift();
        }

        if (i >= k - 1) {
            result.push(nums[deque[0]]);
        }
    }

    return result;
};