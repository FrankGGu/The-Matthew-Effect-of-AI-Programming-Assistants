var shortestPathAllKeys = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    let startR, startC;
    let targetKeysMask = 0; // Bitmask representing all unique keys in the grid

    // Find start position and calculate targetKeysMask
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            const char = grid[r][c];
            if (char === '@') {
                startR = r;
                startC = c;
            } else if (char >= 'a' && char <= 'f') {
                targetKeysMask |= (1 << (char.charCodeAt(0) - 'a'.charCodeAt(0)));
            }
        }
    }

    // BFS setup
    const queue = [];
    // State: [row, col, keys_mask, steps]
    queue.push([startR, startC, 0, 0]);

    // Visited set: "row,col,keys_mask"
    const visited = new Set();
    visited.add(`${startR},${startC},0`);

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    while (queue.length > 0) {
        const [r, c, keys_mask, steps] = queue.shift();

        // If all target keys are collected, return steps
        if (keys_mask === targetKeysMask) {
            return steps;
        }

        // Explore neighbors
        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            // Check bounds
            if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                continue;
            }

            const char = grid[nr][nc];

            // If it's a wall, skip
            if (char === '#') {
                continue;
            }

            let new_keys_mask = keys_mask;

            // If it's a key
            if (char >= 'a' && char <= 'f') {
                const key_bit = 1 << (char.charCodeAt(0) - 'a'.charCodeAt(0));
                new_keys_mask |= key_bit;
            }
            // If it's a lock
            else if (char >= 'A' && char <= 'F') {
                const lock_bit = 1 << (char.charCodeAt(0) - 'A'.charCodeAt(0));
                // If we don't have the key for this lock, skip
                if ((keys_mask & lock_bit) === 0) {
                    continue;
                }
            }
            // If it's '@' or '.' or we have the key for the lock, it's traversable

            const visited_key = `${nr},${nc},${new_keys_mask}`;
            if (!visited.has(visited_key)) {
                visited.add(visited_key);
                queue.push([nr, nc, new_keys_mask, steps + 1]);
            }
        }
    }

    // If queue becomes empty and we haven't found all keys
    return -1;
};