var getBiggestThreeRhombusSums = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const allSums = new Set();

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            // Rhombus of size 0 (single cell)
            allSums.add(grid[r][c]);

            // Rhombus of size k > 0
            // k is the distance from the center (r, c) to any corner.
            // For a rhombus to exist, all its corners must be within grid bounds.
            // Top corner: (r-k, c)
            // Bottom corner: (r+k, c)
            // Left corner: (r, c-k)
            // Right corner: (r, c+k)
            for (let k = 1; ; k++) {
                // Check if all four corners are within grid bounds
                if (r - k < 0 || r + k >= m || c - k < 0 || c + k >= n) {
                    break; // Rhombus is too large, or its corners are out of bounds
                }

                let currentSum = 0;
                // Add the four corner cells
                currentSum += grid[r - k][c]; // Top corner
                currentSum += grid[r + k][c]; // Bottom corner
                currentSum += grid[r][c - k]; // Left corner
                currentSum += grid[r][c + k]; // Right corner

                // Add cells on the four sides (excluding the corners, which are already added)
                // Each side has k-1 cells between its corners for k > 1.
                // If k=1, this loop does not run, which is correct as there are no intermediate cells.

                // Top-right segment: from (r-k, c) to (r, c+k)
                // Cells are (r-k+i, c+i) for i from 1 to k-1
                for (let i = 1; i < k; i++) {
                    currentSum += grid[r - k + i][c + i];
                }
                // Bottom-right segment: from (r, c+k) to (r+k, c)
                // Cells are (r+i, c+k-i) for i from 1 to k-1
                for (let i = 1; i < k; i++) {
                    currentSum += grid[r + i][c + k - i];
                }
                // Bottom-left segment: from (r+k, c) to (r, c-k)
                // Cells are (r+k-i, c-i) for i from 1 to k-1
                for (let i = 1; i < k; i++) {
                    currentSum += grid[r + k - i][c - i];
                }
                // Top-left segment: from (r, c-k) to (r-k, c)
                // Cells are (r-i, c-k+i) for i from 1 to k-1
                for (let i = 1; i < k; i++) {
                    currentSum += grid[r - i][c - k + i];
                }

                allSums.add(currentSum);
            }
        }
    }

    // Convert the set of unique sums to an array
    const result = Array.from(allSums);
    // Sort the sums in descending order
    result.sort((a, b) => b - a); 

    // Return the top 3 biggest sums (or fewer if less than 3 unique sums exist)
    return result.slice(0, 3);
};