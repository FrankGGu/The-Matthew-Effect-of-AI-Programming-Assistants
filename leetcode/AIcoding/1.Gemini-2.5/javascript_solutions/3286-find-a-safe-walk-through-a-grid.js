var shortestPathBinaryMatrix = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    if (grid[0][0] === 1 || grid[rows - 1][cols - 1] === 1) {
        return -1;
    }

    const queue = [[0, 0, 1]];
    const visited = new Array(rows).fill(0).map(() => new Array(cols).fill(false));
    visited[0][0] = true;

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],           [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    while (queue.length > 0) {
        const [r, c, dist] = queue.shift();

        if (r === rows - 1 && c === cols - 1) {
            return dist;
        }

        for (const [dr, dc] of directions) {
            const newR = r + dr;
            const newC = c + dc;

            if (
                newR >= 0 && newR < rows &&
                newC >= 0 && newC < cols &&
                grid[newR][newC] === 0 &&
                !visited[newR][newC]
            ) {
                visited[newR][newC] = true;
                queue.push([newR, newC, dist + 1]);
            }
        }
    }

    return -1;
};