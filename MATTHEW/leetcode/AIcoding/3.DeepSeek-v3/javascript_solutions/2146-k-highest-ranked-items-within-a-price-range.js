var highestRankedKItems = function(grid, pricing, start, k) {
    const [low, high] = pricing;
    const [startRow, startCol] = start;
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const visited = Array.from({ length: m }, () => new Array(n).fill(false));
    const queue = [[startRow, startCol]];
    visited[startRow][startCol] = true;
    const result = [];

    while (queue.length > 0 && result.length < k) {
        const levelSize = queue.length;
        const levelItems = [];

        for (let i = 0; i < levelSize; i++) {
            const [row, col] = queue.shift();
            const price = grid[row][col];

            if (price >= low && price <= high && price !== 1) {
                levelItems.push([row, col, price]);
            }

            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && !visited[newRow][newCol] && grid[newRow][newCol] !== 0) {
                    visited[newRow][newCol] = true;
                    queue.push([newRow, newCol]);
                }
            }
        }

        levelItems.sort((a, b) => {
            if (a[2] !== b[2]) return a[2] - b[2];
            if (a[0] !== b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        for (const item of levelItems) {
            if (result.length < k) {
                result.push([item[0], item[1]]);
            } else {
                break;
            }
        }
    }

    return result;
};