var shiftGrid = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const totalElements = m * n;

    // Create a new grid for the result
    const result = Array(m).fill(0).map(() => Array(n).fill(0));

    // Iterate through each element in the original grid
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            // Calculate the 1D index of the current element
            const original1DIndex = r * n + c;

            // Calculate the new 1D index after k shifts
            const new1DIndex = (original1DIndex + k) % totalElements;

            // Convert the new 1D index back to 2D coordinates
            const newR = Math.floor(new1DIndex / n);
            const newC = new1DIndex % n;

            // Place the element in its new position in the result grid
            result[newR][newC] = grid[r][c];
        }
    }

    return result;
};