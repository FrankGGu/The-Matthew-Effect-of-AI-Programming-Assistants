var rotateGrid = function(grid, k) {
    const rows = grid.length;
    const cols = grid[0].length;

    const numLayers = Math.floor(Math.min(rows, cols) / 2);

    for (let layer = 0; layer < numLayers; layer++) {
        const r1 = layer;
        const c1 = layer;
        const r2 = rows - 1 - layer;
        const c2 = cols - 1 - layer;

        const layerElements = [];

        // Extract elements for the current layer
        // Top row (left to right)
        for (let c = c1; c <= c2; c++) {
            layerElements.push(grid[r1][c]);
        }
        // Right column (top to bottom)
        for (let r = r1 + 1; r <= r2; r++) {
            layerElements.push(grid[r][c2]);
        }
        // Bottom row (right to left), only if it's a distinct row from top
        if (r1 !== r2) {
            for (let c = c2 - 1; c >= c1; c--) {
                layerElements.push(grid[r2][c]);
            }
        }
        // Left column (bottom to top), only if it's a distinct column from right
        if (c1 !== c2) {
            for (let r = r2 - 1; r >= r1 + 1; r--) {
                layerElements.push(grid[r][c1]);
            }
        }

        const effectiveK = k % layerElements.length;

        // Rotate the elements
        const rotatedElements = [...layerElements.slice(effectiveK), ...layerElements.slice(0, effectiveK)];

        // Place rotated elements back into the grid
        let idx = 0;

        // Top row (left to right)
        for (let c = c1; c <= c2; c++) {
            grid[r1][c] = rotatedElements[idx++];
        }
        // Right column (top to bottom)
        for (let r = r1 + 1; r <= r2; r++) {
            grid[r][c2] = rotatedElements[idx++];
        }
        // Bottom row (right to left), only if distinct row
        if (r1 !== r2) {
            for (let c = c2 - 1; c >= c1; c--) {
                grid[r2][c] = rotatedElements[idx++];
            }
        }
        // Left column (bottom to top), only if distinct column
        if (c1 !== c2) {
            for (let r = r2 - 1; r >= r1 + 1; r--) {
                grid[r][c1] = rotatedElements[idx++];
            }
        }
    }

    return grid;
};