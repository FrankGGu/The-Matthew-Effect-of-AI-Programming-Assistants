function solve(grid, startRow, startCol, startDir) {
    // Directions: Up, Right, Down, Left
    // Corresponds to startDir: 0, 1, 2, 3
    const dr = [-1, 0, 1, 0];
    const dc = [0, 1, 0, -1];

    // Reflection maps for '/' mirror
    // new_dir_idx = slash_map[current_dir_idx]
    // Up (0) -> Right (1)
    // Right (1) -> Up (0)
    // Down (2) -> Left (3)
    // Left (3) -> Down (2)
    const slash_map = [1, 0, 3, 2];

    // Reflection maps for '\' mirror
    // new_dir_idx = backslash_map[current_dir_idx]
    // Up (0) -> Left (3)
    // Right (1) -> Down (2)
    // Down (2) -> Right (1)
    // Left (3) -> Up (0)
    const backslash_map = [3, 2, 1, 0];

    const m = grid.length;
    const n = grid[0].length;

    let r = startRow;
    let c = startCol;
    let dir = startDir; // 0:Up, 1:Right, 2:Down, 3:Left

    while (r >= 0 && r < m && c >= 0 && c < n) {
        const cell = grid[r][c];

        if (cell === '/') {
            dir = slash_map[dir];
        } else if (cell === '\\') {
            dir = backslash_map[dir];
        }
        // If cell is '.', direction remains unchanged

        // Move to the next cell
        r += dr[dir];
        c += dc[dir];
    }

    // The ray has exited the grid.
    // The current (r, c) is the first out-of-bounds position.
    return [r, c];
}