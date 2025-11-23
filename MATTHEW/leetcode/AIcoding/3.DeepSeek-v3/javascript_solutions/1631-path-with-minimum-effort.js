var minimumEffortPath = function(heights) {
    const rows = heights.length;
    const cols = heights[0].length;
    const dirs = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    let left = 0, right = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (i > 0) right = Math.max(right, Math.abs(heights[i][j] - heights[i-1][j]));
            if (j > 0) right = Math.max(right, Math.abs(heights[i][j] - heights[i][j-1]));
        }
    }

    const canReach = (maxEffort) => {
        const visited = new Array(rows).fill().map(() => new Array(cols).fill(false));
        const queue = [[0, 0]];
        visited[0][0] = true;

        while (queue.length) {
            const [x, y] = queue.shift();
            if (x === rows - 1 && y === cols - 1) return true;

            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                    const effort = Math.abs(heights[nx][ny] - heights[x][y]);
                    if (effort <= maxEffort) {
                        visited[nx][ny] = true;
                        queue.push([nx, ny]);
                    }
                }
            }
        }
        return false;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canReach(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};