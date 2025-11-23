var mctFromLeafValues = function(arr) {
    let res = 0;
    // The stack will store elements in decreasing order.
    // We add Infinity as a sentinel to handle boundary conditions for the leftmost element.
    let stack = [Infinity]; 

    for (let x of arr) {
        // While the current element 'x' is greater than or equal to the top of the stack,
        // it means the top of the stack is a "valley" element that must be combined
        // with one of its neighbors (the element below it in the stack or 'x' itself).
        // To minimize the sum, this "valley" element 'mid' should be multiplied
        // by the smaller of its two neighbors.
        while (stack[stack.length - 1] <= x) {
            let mid = stack.pop(); // 'mid' is the element being removed (forming a non-leaf node).

            // The cost incurred is 'mid' multiplied by the smaller of its two neighbors:
            // 1. The element currently at the top of the stack (its left neighbor).
            // 2. The current element 'x' (its right neighbor).
            res += mid * Math.min(stack[stack.length - 1], x);
        }
        stack.push(x); // Push the current element onto the stack, maintaining the decreasing order property.
    }

    // After processing all elements in 'arr', there might be remaining elements in the stack.
    // These elements are in decreasing order (e.g., [Infinity, 12, 10]).
    // We need to combine them until only the sentinel (Infinity) and the overall maximum remain.
    // Each time, the second-to-last element ('mid') is combined with the last element (stack.peek()).
    // The cost is 'mid' * stack.peek().
    while (stack.length > 2) {
        let mid = stack.pop();
        res += mid * stack[stack.length - 1];
    }

    return res;
};