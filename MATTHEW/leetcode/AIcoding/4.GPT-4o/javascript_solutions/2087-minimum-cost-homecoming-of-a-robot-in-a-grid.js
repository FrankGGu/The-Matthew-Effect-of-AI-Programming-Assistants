var minCost = function(startPos, homePos, rowCount, colCount, cells) {
    const grid = Array.from({ length: rowCount }, () => Array(colCount).fill(0));
    for (const [r, c, cost] of cells) {
        grid[r - 1][c - 1] = cost;
    }

    const [startX, startY] = startPos;
    const [homeX, homeY] = homePos;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const dp = Array.from({ length: rowCount }, () => Array(colCount).fill(Infinity));
    dp[startX][startY] = 0;

    const queue = [[startX, startY]];
    while (queue.length) {
        const [x, y] = queue.shift();

        for (const [dx, dy] of directions) {
            const newX = x + dx;
            const newY = y + dy;
            if (newX >= 0 && newX < rowCount && newY >= 0 && newY < colCount) {
                const newCost = dp[x][y] + grid[newX][newY];
                if (newCost < dp[newX][newY]) {
                    dp[newX][newY] = newCost;
                    queue.push([newX, newY]);
                }
            }
        }
    }

    return dp[homeX][homeY];
};