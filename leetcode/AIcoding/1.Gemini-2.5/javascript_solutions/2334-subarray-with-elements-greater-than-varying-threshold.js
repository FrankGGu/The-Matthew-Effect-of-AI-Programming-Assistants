var validSubarraySize = function(nums, threshold) {
    const n = nums.length;
    const stack = []; // Stores indices in increasing order of nums[index]

    for (let i = 0; i < n; i++) {
        // While the current number is less than or equal to the number at the top of the stack,
        // it means the element at stack.peek() has found its right boundary (i).
        while (stack.length > 0 && nums[stack[stack.length - 1]] >= nums[i]) {
            const j = stack.pop(); // j is the index of the element being considered as the minimum
            const leftBoundary = stack.length === 0 ? -1 : stack[stack.length - 1];
            const length = i - leftBoundary - 1; // Current subarray length where nums[j] is the minimum

            // Check the condition: nums[j] > threshold * length
            if (nums[j] > threshold * length) {
                return true;
            }
        }
        stack.push(i);
    }

    // After iterating through all elements, any remaining elements in the stack
    // mean they are greater than or equal to all elements to their right (up to n-1).
    // For these elements, the right boundary is the end of the array (n).
    while (stack.length > 0) {
        const j = stack.pop();
        const leftBoundary = stack.length === 0 ? -1 : stack[stack.length - 1];
        const length = n - leftBoundary - 1; // The right boundary is n (exclusive)

        // Check the condition: nums[j] > threshold * length
        if (nums[j] > threshold * length) {
            return true;
        }
    }

    return false;
};