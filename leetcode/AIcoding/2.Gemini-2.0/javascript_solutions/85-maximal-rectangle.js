var maximalRectangle = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0].length;
    const heights = new Array(cols).fill(0);
    let maxArea = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }
        maxArea = Math.max(maxArea, largestRectangleArea(heights));
    }

    return maxArea;

    function largestRectangleArea(heights) {
        const stack = [];
        let maxArea = 0;
        heights = [0, ...heights, 0];

        for (let i = 0; i < heights.length; i++) {
            while (stack.length > 0 && heights[i] < heights[stack[stack.length - 1]]) {
                const top = stack.pop();
                const area = heights[top] * (i - stack[stack.length - 1] - 1);
                maxArea = Math.max(maxArea, area);
            }
            stack.push(i);
        }

        return maxArea;
    }
};