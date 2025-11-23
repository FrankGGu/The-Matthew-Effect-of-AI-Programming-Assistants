var maximalRectangle = function(matrix) {
    if (!matrix.length || !matrix[0].length) return 0;

    const heights = new Array(matrix[0].length).fill(0);
    let maxArea = 0;

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[0].length; j++) {
            heights[j] = matrix[i][j] === '1' ? heights[j] + 1 : 0;
        }
        maxArea = Math.max(maxArea, largestRectangleArea(heights));
    }

    return maxArea;
};

var largestRectangleArea = function(heights) {
    heights.push(0);
    const stack = [];
    let maxArea = 0;

    for (let i = 0; i < heights.length; i++) {
        while (stack.length && heights[stack[stack.length - 1]] > heights[i]) {
            const h = heights[stack.pop()];
            const w = stack.length ? i - stack[stack.length - 1] - 1 : i;
            maxArea = Math.max(maxArea, h * w);
        }
        stack.push(i);
    }

    return maxArea;
};