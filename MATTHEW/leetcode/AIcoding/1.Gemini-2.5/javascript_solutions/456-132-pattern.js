var find132pattern = function(nums) {
    const n = nums.length;
    if (n < 3) {
        return false;
    }

    let thirdElement = Number.MIN_SAFE_INTEGER; // Represents nums[k] (the '2' in 132)
    const stack = []; // Stores potential nums[j] candidates (the '3' in 132), in decreasing order

    // Iterate from right to left. nums[i] in the loop is the '1' in 132 pattern.
    for (let i = n - 1; i >= 0; i--) {
        // If current element nums[i] is smaller than thirdElement,
        // we have found nums[i] < thirdElement (nums[k]).
        // Since thirdElement was previously set from a stack element (nums[j]),
        // we know thirdElement < nums[j].
        // Thus, nums[i] < nums[k] < nums[j] is found.
        if (nums[i] < thirdElement) {
            return true;
        }

        // While stack is not empty and current element nums[i] is greater than the stack top,
        // it means stack.peek() can be a potential nums[k] (it's smaller than nums[i]).
        // And nums[i] is a potential nums[j] (the '3' in 132).
        while (stack.length > 0 && nums[i] > stack[stack.length - 1]) {
            // Pop elements from stack and update thirdElement.
            // thirdElement should be the largest possible nums[k] found so far
            // that is smaller than some nums[j] (which was just popped from the stack).
            thirdElement = stack.pop();
        }

        // Push current element onto the stack. It's a candidate for nums[j] (the '3' in 132).
        // The stack maintains elements in decreasing order.
        stack.push(nums[i]);
    }

    return false;
};