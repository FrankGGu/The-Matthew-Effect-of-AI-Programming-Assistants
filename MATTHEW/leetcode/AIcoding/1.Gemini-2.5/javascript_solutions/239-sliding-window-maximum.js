var maxSlidingWindow = function(nums, k) {
    const result = [];
    const deque = []; // Stores indices

    for (let i = 0; i < nums.length; i++) {
        // Remove indices that are out of the current window [i-k+1, i]
        if (deque.length > 0 && deque[0] <= i - k) {
            deque.shift();
        }

        // Remove elements from the back of the deque that are smaller than or equal to the current element
        // because they will never be the maximum in any future window that includes them.
        while (deque.length > 0 && nums[deque[deque.length - 1]] <= nums[i]) {
            deque.pop();
        }

        // Add the current element's index to the back of the deque
        deque.push(i);

        // If the window has fully formed (i.e., we have processed at least k elements)
        // the maximum element for the current window is at the front of the deque.
        if (i >= k - 1) {
            result.push(nums[deque[0]]);
        }
    }

    return result;
};