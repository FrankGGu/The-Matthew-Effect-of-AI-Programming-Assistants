var gridTeleportationTraversal = function(grid, start, end, teleporters) {
    const rows = grid.length;
    const cols = grid[0].length;
    const queue = [[start[0], start[1], 0]];
    const visited = new Set();
    visited.add(start[0] + "," + start[1]);

    while (queue.length > 0) {
        const [row, col, steps] = queue.shift();

        if (row === end[0] && col === end[1]) {
            return steps;
        }

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] === 1 && !visited.has(newRow + "," + newCol)) {
                queue.push([newRow, newCol, steps + 1]);
                visited.add(newRow + "," + newCol);
            }
        }

        for (const teleporter of teleporters) {
            if (row === teleporter[0] && col === teleporter[1]) {
                const newRow = teleporter[2];
                const newCol = teleporter[3];
                if (grid[newRow][newCol] === 1 && !visited.has(newRow + "," + newCol)) {
                    queue.push([newRow, newCol, steps + 1]);
                    visited.add(newRow + "," + newCol);
                }
            } else if (row === teleporter[2] && col === teleporter[3]) {
                const newRow = teleporter[0];
                const newCol = teleporter[1];
                if (grid[newRow][newCol] === 1 && !visited.has(newRow + "," + newCol)) {
                    queue.push([newRow, newCol, steps + 1]);
                    visited.add(newRow + "," + newCol);
                }
            }
        }
    }

    return -1;
};