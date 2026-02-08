var nextGreaterElements = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(-1);
    const stack = []; // Stores indices

    // Iterate twice the length of the array to handle circularity
    // We iterate from right to left (2*n - 1 down to 0)
    // This allows us to find the next greater element to the right, including wrapping around
    for (let i = 2 * n - 1; i >= 0; i--) {
        const currentIdx = i % n;
        const currentNum = nums[currentIdx];

        // Pop elements from stack that are less than or equal to currentNum
        // These elements cannot be the next greater element for currentNum
        // and they are also not greater than currentNum for any future elements
        while (stack.length > 0 && nums[stack[stack.length - 1]] <= currentNum) {
            stack.pop();
        }

        // If stack is not empty, the top of the stack is the next greater element
        // for the current number (only for the first pass of each original index)
        // The values for result[currentIdx] will be correctly set when 'i' is in the range [0, n-1]
        // because by then, the stack will contain all relevant elements from the "circular" part.
        if (stack.length > 0) {
            result[currentIdx] = nums[stack[stack.length - 1]];
        }
        // If stack is empty, result[currentIdx] remains -1 (initialized value)

        // Push the current index onto the stack
        stack.push(currentIdx);
    }

    return result;
};