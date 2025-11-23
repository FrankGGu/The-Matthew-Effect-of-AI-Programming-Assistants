var orangesRotting = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let freshCount = 0;
    let queue = [];

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 1) freshCount++;
            if (grid[r][c] === 2) queue.push([r, c]);
        }
    }

    if (freshCount === 0) return 0;

    let minutes = 0;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    while (queue.length > 0) {
        let size = queue.length;
        for (let i = 0; i < size; i++) {
            const [r, c] = queue.shift();
            for (const [dr, dc] of directions) {
                const newRow = r + dr;
                const newCol = c + dc;
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] === 1) {
                    grid[newRow][newCol] = 2;
                    freshCount--;
                    queue.push([newRow, newCol]);
                }
            }
        }
        minutes++;
    }

    return freshCount === 0 ? minutes - 1 : -1;
};