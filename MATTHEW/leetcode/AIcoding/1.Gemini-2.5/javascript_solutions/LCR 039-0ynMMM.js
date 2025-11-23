var largestRectangleArea = function(heights) {
    let maxArea = 0;
    const stack = []; // Stores indices of heights in increasing order

    for (let i = 0; i <= heights.length; i++) {
        const currentHeight = (i === heights.length) ? 0 : heights[i];

        while (stack.length > 0 && currentHeight <= heights[stack[stack.length - 1]]) {
            const hIndex = stack.pop();
            const height = heights[hIndex];

            const width = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;

            maxArea = Math.max(maxArea, height * width);
        }
        stack.push(i);
    }

    return maxArea;
};