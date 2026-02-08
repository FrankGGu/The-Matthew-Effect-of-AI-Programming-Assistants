var minimumMoves = function(grid) {
    const n = grid.length;
    const queue = [];
    const visited = new Set();
    const start = JSON.stringify([0, 0, 0, 1, 0]);
    queue.push([0, 0, 0, 1, 0]);
    visited.add(start);

    while (queue.length > 0) {
        const [x1, y1, x2, y2, moves] = queue.shift();

        if (x1 === n - 1 && y1 === n - 2 && x2 === n - 1 && y2 === n - 1) {
            return moves;
        }

        // Move right
        if (y2 + 1 < n && grid[x2][y2 + 1] === 0 && (x1 === x2 || grid[x1][y1 + 1] === 0)) {
            const newPos = [x1, y1 + 1, x2, y2 + 1, moves + 1];
            const key = JSON.stringify(newPos);
            if (!visited.has(key)) {
                visited.add(key);
                queue.push(newPos);
            }
        }

        // Move down
        if (x2 + 1 < n && grid[x2 + 1][y2] === 0 && (y1 === y2 || grid[x1 + 1][y1] === 0)) {
            const newPos = [x1 + 1, y1, x2 + 1, y2, moves + 1];
            const key = JSON.stringify(newPos);
            if (!visited.has(key)) {
                visited.add(key);
                queue.push(newPos);
            }
        }

        // Rotate clockwise
        if (x1 === x2 && x1 + 1 < n && y1 + 1 < n && grid[x1 + 1][y1] === 0 && grid[x1 + 1][y1 + 1] === 0) {
            const newPos = [x1, y1, x1 + 1, y1, moves + 1];
            const key = JSON.stringify(newPos);
            if (!visited.has(key)) {
                visited.add(key);
                queue.push(newPos);
            }
        }

        // Rotate counter-clockwise
        if (y1 === y2 && y1 + 1 < n && x1 + 1 < n && grid[x1][y1 + 1] === 0 && grid[x1 + 1][y1 + 1] === 0) {
            const newPos = [x1, y1, x1, y1 + 1, moves + 1];
            const key = JSON.stringify(newPos);
            if (!visited.has(key)) {
                visited.add(key);
                queue.push(newPos);
            }
        }
    }

    return -1;
};