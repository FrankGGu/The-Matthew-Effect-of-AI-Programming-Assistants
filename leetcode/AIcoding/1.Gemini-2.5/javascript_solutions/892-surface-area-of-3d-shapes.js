var surfaceArea = function(grid) {
    let totalArea = 0;
    const N = grid.length;
    const M = grid[0].length;

    for (let i = 0; i < N; i++) {
        for (let j = 0; j < M; j++) {
            const h = grid[i][j];

            if (h === 0) {
                continue;
            }

            // Add top and bottom surfaces
            totalArea += 2;

            // Add exposed vertical surfaces for each of the four directions
            // Up (i-1, j)
            const neighborUp = (i > 0) ? grid[i - 1][j] : 0;
            totalArea += Math.max(0, h - neighborUp);

            // Down (i+1, j)
            const neighborDown = (i < N - 1) ? grid[i + 1][j] : 0;
            totalArea += Math.max(0, h - neighborDown);

            // Left (i, j-1)
            const neighborLeft = (j > 0) ? grid[i][j - 1] : 0;
            totalArea += Math.max(0, h - neighborLeft);

            // Right (i, j+1)
            const neighborRight = (j < M - 1) ? grid[i][j + 1] : 0;
            totalArea += Math.max(0, h - neighborRight);
        }
    }

    return totalArea;
};