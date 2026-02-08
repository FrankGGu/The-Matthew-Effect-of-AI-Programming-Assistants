var highestPeak = function(isWater) {
    const m = isWater.length;
    const n = isWater[0].length;
    const height = Array(m).fill(null).map(() => Array(n).fill(-1));
    const queue = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (isWater[i][j] === 1) {
                height[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col] = queue.shift();

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && height[newRow][newCol] === -1) {
                height[newRow][newCol] = height[row][col] + 1;
                queue.push([newRow, newCol]);
            }
        }
    }

    return height;
};