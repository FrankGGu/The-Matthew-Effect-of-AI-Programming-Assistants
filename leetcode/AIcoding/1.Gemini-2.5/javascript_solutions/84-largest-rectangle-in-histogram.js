var largestRectangleArea = function(heights) {
    let maxArea = 0;
    const stack = []; // Stores indices of bars in increasing order of height

    for (let i = 0; i <= heights.length; i++) {
        const currentHeight = (i === heights.length) ? 0 : heights[i];

        // While the stack is not empty and the current bar is shorter than the bar at the top of the stack
        while (stack.length > 0 && currentHeight < heights[stack[stack.length - 1]]) {
            const h = heights[stack.pop()]; // Height of the bar being popped
            // Calculate width:
            // If stack is empty, it means the popped bar is the smallest so far,
            // and extends from index 0 to current index i-1. Width is i.
            // Otherwise, width is from (stack.top() + 1) to (i - 1).
            // So, width = i - (stack.top() + 1) = i - stack.top() - 1.
            const w = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;
            maxArea = Math.max(maxArea, h * w);
        }
        stack.push(i);
    }

    return maxArea;
};