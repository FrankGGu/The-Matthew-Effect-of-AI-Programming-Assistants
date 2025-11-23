var largestRectangleArea = function(heights) {
    const n = heights.length;
    const stack = [];
    let maxArea = 0;

    for (let i = 0; i <= n; i++) {
        while (stack.length > 0 && (i === n || heights[i] < heights[stack[stack.length - 1]])) {
            const top = stack.pop();
            const width = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;
            maxArea = Math.max(maxArea, heights[top] * width);
        }
        stack.push(i);
    }

    return maxArea;
};