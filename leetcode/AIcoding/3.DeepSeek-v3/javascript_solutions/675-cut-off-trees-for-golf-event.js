var cutOffTree = function(forest) {
    if (forest.length === 0 || forest[0].length === 0) return -1;
    const m = forest.length, n = forest[0].length;
    const trees = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (forest[i][j] > 1) {
                trees.push([forest[i][j], i, j]);
            }
        }
    }
    trees.sort((a, b) => a[0] - b[0]);

    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const bfs = (startX, startY, targetX, targetY) => {
        const visited = new Array(m).fill().map(() => new Array(n).fill(false));
        const queue = [[startX, startY, 0]];
        visited[startX][startY] = true;

        while (queue.length > 0) {
            const [x, y, steps] = queue.shift();
            if (x === targetX && y === targetY) {
                return steps;
            }
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && forest[nx][ny] !== 0) {
                    visited[nx][ny] = true;
                    queue.push([nx, ny, steps + 1]);
                }
            }
        }
        return -1;
    };

    let res = 0;
    let startX = 0, startY = 0;
    for (const [_, x, y] of trees) {
        const steps = bfs(startX, startY, x, y);
        if (steps === -1) return -1;
        res += steps;
        startX = x;
        startY = y;
    }
    return res;
};