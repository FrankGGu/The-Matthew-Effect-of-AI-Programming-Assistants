var largestSubmatrix = function(matrix) {
    const numRows = matrix.length;
    const numCols = matrix[0].length;
    let maxArea = 0;

    // heights array will store the current height of consecutive 1s ending at the current row for each column
    const heights = new Array(numCols).fill(0);

    for (let r = 0; r < numRows; r++) {
        // Update heights for the current row
        for (let c = 0; c < numCols; c++) {
            if (matrix[r][c] === 1) {
                heights[c]++;
            } else {
                heights[c] = 0;
            }
        }

        // Create a sorted copy of the current heights
        // Sorting allows us to find the maximum area by considering each height
        // as the minimum height of a submatrix and extending it as far left as possible.
        // In a sorted array, heights[k] can extend to the right for (numCols - k) columns.
        const sortedHeights = [...heights].sort((a, b) => a - b);

        // Calculate potential areas for the current row
        for (let k = 0; k < numCols; k++) {
            const currentHeight = sortedHeights[k];
            const currentWidth = numCols - k; // Number of columns that have at least this height
            maxArea = Math.max(maxArea, currentHeight * currentWidth);
        }
    }

    return maxArea;
};