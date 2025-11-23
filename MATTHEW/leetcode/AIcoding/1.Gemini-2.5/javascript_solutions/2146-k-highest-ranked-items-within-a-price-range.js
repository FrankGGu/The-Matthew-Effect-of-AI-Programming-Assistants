var highestRankedKItems = function(grid, priceRange, start, k) {
    const m = grid.length;
    const n = grid[0].length;
    const low = priceRange[0];
    const high = priceRange[1];

    const queue = [];
    queue.push([start[0], start[1], 0]); // [row, col, distance]

    const visited = Array(m).fill(0).map(() => Array(n).fill(false));
    visited[start[0]][start[1]] = true;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    const items = []; // Stores [distance, price, row, col]

    let head = 0;
    while (head < queue.length) {
        const [r, c, dist] = queue[head++];

        const price = grid[r][c];

        // Check if current cell is a valid item (not a wall '0' and within price range)
        if (price !== 0 && price >= low && price <= high) {
            items.push([dist, price, r, c]);
        }

        // Explore neighbors
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && grid[nr][nc] !== 0) {
                visited[nr][nc] = true;
                queue.push([nr, nc, dist + 1]);
            }
        }
    }

    // Sort items based on criteria:
    // 1. distance (ascending)
    // 2. price (ascending)
    // 3. row (ascending)
    // 4. column (ascending)
    items.sort((a, b) => {
        if (a[0] !== b[0]) { // distance
            return a[0] - b[0];
        }
        if (a[1] !== b[1]) { // price
            return a[1] - b[1];
        }
        if (a[2] !== b[2]) { // row
            return a[2] - b[2];
        }
        return a[3] - b[3]; // column
    });

    // Take the top k items and format the output
    const result = [];
    for (let i = 0; i < Math.min(k, items.length); i++) {
        result.push([items[i][2], items[i][3]]);
    }

    return result;
};