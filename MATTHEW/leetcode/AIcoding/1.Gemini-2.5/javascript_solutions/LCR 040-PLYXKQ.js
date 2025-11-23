var maximalRectangle = function(matrix) {
    if (matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0].length;
    let maxArea = 0;

    // heights array will store the current height of consecutive '1's ending at each column
    // for the current row being processed.
    const heights = new Array(cols).fill(0);

    for (let i = 0; i < rows; i++) {
        // Update heights for the current row
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }

        // Calculate the largest rectangle in the current histogram (heights array)
        let currentMaxArea = 0;
        const stack = []; // Stores indices of bars in increasing order of height

        // Iterate through heights array, including a dummy 0 at the end to pop all elements
        for (let k = 0; k <= cols; k++) {
            // Get the current height (or 0 if at the end of array)
            const h = (k === cols) ? 0 : heights[k];

            // While stack is not empty and current height is less than or equal to the height
            // of the bar at the top of the stack (or at the end of array)
            while (stack.length > 0 && h <= heights[stack[stack.length - 1]]) {
                const heightPopped = heights[stack.pop()];
                // Calculate width: if stack is empty, it means the popped bar extends to the
                // beginning of the histogram (index 0). Otherwise, it extends from the
                // previous smaller bar on the stack to the current index k-1.
                const width = stack.length === 0 ? k : k - stack[stack.length - 1] - 1;
                currentMaxArea = Math.max(currentMaxArea, heightPopped * width);
            }
            stack.push(k);
        }
        maxArea = Math.max(maxArea, currentMaxArea);
    }

    return maxArea;
};