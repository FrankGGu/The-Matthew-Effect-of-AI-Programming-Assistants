var constrainedSubsetSum = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n);
    const deque = []; // Stores indices, maintaining dp values in decreasing order

    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        // Remove elements from the front of the deque if their index is out of the window [i-k, i-1]
        // The element at deque[0] corresponds to dp[j] where j is the index.
        // We need j >= i - k. So if deque[0] < i - k, it's too old.
        while (deque.length > 0 && deque[0] < i - k) {
            deque.shift();
        }

        // Calculate dp[i]
        // dp[i] = nums[i] + max(0, dp[j]) for j in [i-k, i-1]
        // The maximum dp[j] in the current window is at deque[0].
        // We use Math.max(0, ...) because we can always start a new subsequence with nums[i]
        // if extending a previous one would result in a smaller sum (i.e., dp[deque[0]] is negative).
        if (deque.length > 0) {
            dp[i] = nums[i] + Math.max(0, dp[deque[0]]);
        } else {
            // If the deque is empty, it means there are no valid previous elements in the window
            // or it's the first element. We just take nums[i] itself.
            dp[i] = nums[i];
        }

        // Update the overall maximum sum found so far
        maxSum = Math.max(maxSum, dp[i]);

        // Maintain the deque in decreasing order of dp values.
        // Remove elements from the back of the deque if dp[last_element_index] is less than or equal to dp[i].
        // This ensures that deque[0] always points to the index with the maximum dp value
        // within the current sliding window.
        while (deque.length > 0 && dp[deque[deque.length - 1]] <= dp[i]) {
            deque.pop();
        }

        // Add the current index to the back of the deque
        deque.push(i);
    }

    return maxSum;
};