var longestSubarray = function(nums, limit) {
    let left = 0;
    let maxLength = 0;
    const minDeque = []; // Stores indices of elements in increasing order
    const maxDeque = []; // Stores indices of elements in decreasing order

    for (let right = 0; right < nums.length; right++) {
        // Maintain minDeque
        while (minDeque.length > 0 && nums[minDeque[minDeque.length - 1]] >= nums[right]) {
            minDeque.pop();
        }
        minDeque.push(right);

        // Maintain maxDeque
        while (maxDeque.length > 0 && nums[maxDeque[maxDeque.length - 1]] <= nums[right]) {
            maxDeque.pop();
        }
        maxDeque.push(right);

        // Check the condition
        while (nums[maxDeque[0]] - nums[minDeque[0]] > limit) {
            left++;
            // Remove elements from the front of deques if they are outside the current window [left, right]
            if (minDeque[0] < left) {
                minDeque.shift();
            }
            if (maxDeque[0] < left) {
                maxDeque.shift();
            }
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};