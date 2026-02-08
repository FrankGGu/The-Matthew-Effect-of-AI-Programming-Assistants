var shortestPathBinaryMatrix = function(grid) {
    const n = grid.length;

    if (grid[0][0] === 1 || grid[n - 1][n - 1] === 1) {
        return -1;
    }

    if (n === 1 && grid[0][0] === 0) {
        return 1;
    }

    const queue = [[0, 0, 1]];
    const visited = new Set();
    visited.add("0,0");

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],           [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    while (queue.length > 0) {
        const [r, c, dist] = queue.shift();

        for (const [dr, dc] of directions) {
            const newR = r + dr;
            const newC = c + dc;

            if (
                newR >= 0 && newR < n &&
                newC >= 0 && newC < n &&
                grid[newR][newC] === 0 &&
                !visited.has(`${newR},${newC}`)
            ) {
                if (newR === n - 1 && newC === n - 1) {
                    return dist + 1;
                }

                visited.add(`${newR},${newC}`);
                queue.push([newR, newC, dist + 1]);
            }
        }
    }

    return -1;
};