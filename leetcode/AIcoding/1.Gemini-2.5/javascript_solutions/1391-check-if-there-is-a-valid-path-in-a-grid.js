var hasValidPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // Define relative changes for directions: Up, Down, Left, Right
    // Index mapping: 0: Up, 1: Down, 2: Left, 3: Right
    const dr_dc_map = [
        [-1, 0], // 0: Up
        [1, 0],  // 1: Down
        [0, -1], // 2: Left
        [0, 1]   // 3: Right
    ];

    // Define the openings for each street type (using direction indices)
    // For example, street type 1 connects Left (2) and Right (3)
    const street_openings = {
        1: [2, 3], // Left, Right
        2: [0, 1], // Up, Down
        3: [1, 2], // Down, Left
        4: [1, 3], // Down, Right
        5: [0, 2], // Up, Left
        6: [0, 3]  // Up, Right
    };

    // Define the opposite direction for connection checking
    // If we move Up (0) from current cell, the neighbor must accept Down (1)
    const opposite_dir_map = {
        0: 1, // Up -> Down
        1: 0, // Down -> Up
        2: 3, // Left -> Right
        3: 2  // Right -> Left
    };

    const queue = [[0, 0]];
    const visited = new Set();
    visited.add('0,0'); // Store visited cells as 'row,col' strings

    while (queue.length > 0) {
        const [r, c] = queue.shift();

        // If we reached the target cell, a valid path exists
        if (r === m - 1 && c === n - 1) {
            return true;
        }

        const current_street_type = grid[r][c];
        const possible_exits = street_openings[current_street_type];

        for (const exit_dir_idx of possible_exits) {
            const [dr, dc] = dr_dc_map[exit_dir_idx];
            const nr = r + dr;
            const nc = c + dc;
            const neighbor_key = `${nr},${nc}`;

            // Check bounds
            if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                continue;
            }

            // Check if already visited
            if (visited.has(neighbor_key)) {
                continue;
            }

            const neighbor_street_type = grid[nr][nc];
            // The direction the neighbor must be able to connect from
            const required_incoming_dir_for_neighbor = opposite_dir_map[exit_dir_idx];

            // Check if the neighbor's street type has an opening that matches
            // the required incoming direction
            if (street_openings[neighbor_street_type].includes(required_incoming_dir_for_neighbor)) {
                visited.add(neighbor_key);
                queue.push([nr, nc]);
            }
        }
    }

    // If the queue becomes empty and the target was not reached, no valid path exists
    return false;
};