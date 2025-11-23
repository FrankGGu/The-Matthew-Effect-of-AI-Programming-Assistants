var totalSteps = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return 0;
    }

    // dp[i] stores the number of steps it takes for nums[i] to be removed.
    // If nums[i] is never removed, dp[i] remains 0.
    const dp = new Array(n).fill(0);
    let maxSteps = 0;

    // stack stores indices of elements that form a non-increasing subsequence from left to right.
    // Each element in the stack is a potential "left barrier" for elements to its right.
    const stack = [];

    for (let i = 0; i < n; i++) {
        let currentMaxStepsForRemovedElements = 0;

        // While stack is not empty and the element at stack.top() is less than or equal to nums[i]:
        // These elements (nums[stack.top()]) are "consumed" by nums[i] or elements to its left.
        // They will eventually be removed.
        while (stack.length > 0 && nums[stack[stack.length - 1]] <= nums[i]) {
            // The dp value of the popped element represents the steps it takes for that element to be removed.
            // This value contributes to the `currentMaxStepsForRemovedElements` because `nums[i]`
            // will be compared to the element that ultimately removes `nums[stack.top()]`.
            // If `nums[stack.top()]` is removed in `dp[stack.top()]` steps, then `nums[i]`
            // will be compared to `nums[stack.top()]`'s predecessor in step `dp[stack.top()] + 1`.
            currentMaxStepsForRemovedElements = Math.max(currentMaxStepsForRemovedElements, dp[stack[stack.length - 1]]);
            stack.pop();
        }

        // If stack is not empty, it means nums[stack.top()] > nums[i].
        // In this case, nums[i] will be removed by nums[stack.top()].
        // The number of steps for nums[i] to be removed is 1 (for itself)
        // plus the maximum steps required to remove any elements between nums[stack.top()] and nums[i]
        // that were smaller than nums[i]. This maximum is captured by `currentMaxStepsForRemovedElements`.
        if (stack.length > 0) {
            dp[i] = 1 + currentMaxStepsForRemovedElements;
            maxSteps = Math.max(maxSteps, dp[i]);
        }

        // Push current index onto stack.
        // The stack maintains indices of elements in decreasing order of their values.
        stack.push(i);
    }

    return maxSteps;
};