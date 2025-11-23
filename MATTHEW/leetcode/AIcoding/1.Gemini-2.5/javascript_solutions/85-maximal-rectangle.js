var maximalRectangle = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0].length;
    let maxArea = 0;
    const heights = new Array(cols).fill(0);

    const largestRectangleInHistogram = (h) => {
        let currentMaxArea = 0;
        const stack = []; // Stores indices

        for (let i = 0; i <= h.length; i++) {
            const currentHeight = (i === h.length) ? 0 : h[i];
            while (stack.length > 0 && currentHeight < h[stack[stack.length - 1]]) {
                const height = h[stack.pop()];
                const width = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;
                currentMaxArea = Math.max(currentMaxArea, height * width);
            }
            stack.push(i);
        }
        return currentMaxArea;
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }
        maxArea = Math.max(maxArea, largestRectangleInHistogram(heights));
    }

    return maxArea;
};