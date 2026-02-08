var numberOfSubarrays = function(nums) {
    const n = nums.length;
    let ans = 0;
    const stack = []; // Stores indices of elements in decreasing order of their values
    const countEqualLeft = new Map(); // Stores the count of valid 'j's for a given index 'i'

    for (let i = 0; i < n; i++) {
        const currentVal = nums[i];
        let currentCount = 0;

        // Pop elements from the stack that are strictly smaller than currentVal.
        // These elements cannot be the left boundary 'j' for currentVal because nums[j] must be equal to currentVal.
        // Also, if they were between a valid 'j' and 'i', they would violate the maximum condition
        // (i.e., nums[k] <= currentVal for all k in [j, i]).
        while (stack.length > 0 && nums[stack[stack.length - 1]] < currentVal) {
            stack.pop();
        }

        // If the stack is not empty and the top element has the same value as currentVal,
        // it means we found a previous index 'p' (stack.top()) such that nums[p] == currentVal,
        // and all elements between 'p' and 'i' (exclusive) are less than or equal to currentVal.
        // In this case, 'p' is a valid 'j'.
        // Furthermore, any 'j'' that formed a valid subarray [j', p] will also form a valid subarray [j', i],
        // because the segment (p, i) only contains elements <= currentVal.
        // So, the number of valid 'j's for current 'i' is 1 (for [i,i]) plus the count of valid 'j's for 'p'.
        if (stack.length > 0 && nums[stack[stack.length - 1]] === currentVal) {
            const prevIndex = stack[stack.length - 1];
            currentCount = countEqualLeft.get(prevIndex) + 1;
        } else {
            // If the stack is empty, or the top element has a value strictly greater than currentVal,
            // then there are no previous 'j's (where nums[j] == currentVal) that satisfy the conditions
            // within the current "visible" range.
            // The only valid subarray ending at 'i' is [i,i] itself.
            currentCount = 1;
        }

        ans += currentCount;
        countEqualLeft.set(i, currentCount);
        stack.push(i);
    }

    return ans;
};