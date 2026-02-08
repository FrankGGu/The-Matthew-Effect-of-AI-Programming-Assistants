var highestPeak = function(isWater) {
    const m = isWater.length;
    const n = isWater[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const queue = [];
    const height = Array.from({ length: m }, () => new Array(n).fill(-1));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (isWater[i][j] === 1) {
                height[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    while (queue.length > 0) {
        const [x, y] = queue.shift();
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && height[nx][ny] === -1) {
                height[nx][ny] = height[x][y] + 1;
                queue.push([nx, ny]);
            }
        }
    }

    return height;
};