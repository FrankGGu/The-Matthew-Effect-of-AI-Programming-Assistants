var islandPerimeter = function(grid) {
    let perimeter = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 1) {
                perimeter += 4; // Start with 4 sides for each land cell

                // Check top neighbor
                if (r > 0 && grid[r - 1][c] === 1) {
                    perimeter -= 2; // Subtract 2 for shared side
                }
                // Check left neighbor
                if (c > 0 && grid[r][c - 1] === 1) {
                    perimeter -= 2; // Subtract 2 for shared side
                }
            }
        }
    }
    return perimeter;
};