function maximalRectangle(matrix) {
    if (matrix.length === 0 || matrix[0].length === 0) return 0;

    let maxArea = 0;
    const heights = new Array(matrix[0].length).fill(0);

    for (let row = 0; row < matrix.length; row++) {
        for (let col = 0; col < matrix[0].length; col++) {
            if (matrix[row][col] === '1') {
                heights[col]++;
            } else {
                heights[col] = 0;
            }
        }

        let area = largestRectangleArea(heights);
        maxArea = Math.max(maxArea, area);
    }

    return maxArea;
}

function largestRectangleArea(heights) {
    const stack = [];
    let maxArea = 0;
    heights.push(0);

    for (let i = 0; i < heights.length; i++) {
        while (stack.length > 0 && heights[i] < heights[stack[stack.length - 1]]) {
            const height = heights[stack.pop()];
            const width = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;
            maxArea = Math.max(maxArea, height * width);
        }
        stack.push(i);
    }

    heights.pop();
    return maxArea;
}