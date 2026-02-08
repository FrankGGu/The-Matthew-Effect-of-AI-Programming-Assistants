var cutOffTree = function(forest) {
    const rows = forest.length;
    const cols = forest[0].length;

    const trees = [];
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (forest[i][j] > 1) {
                trees.push([forest[i][j], i, j]);
            }
        }
    }

    trees.sort((a, b) => a[0] - b[0]);

    const bfs = (start, end) => {
        const queue = [[start[0], start[1], 0]];
        const visited = new Set();
        visited.add(`${start[0]}-${start[1]}`);

        const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

        while (queue.length) {
            const [x, y, dist] = queue.shift();
            if (x === end[0] && y === end[1]) return dist;
            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && forest[nx][ny] !== 0 && !visited.has(`${nx}-${ny}`)) {
                    visited.add(`${nx}-${ny}`);
                    queue.push([nx, ny, dist + 1]);
                }
            }
        }
        return -1;
    };

    let totalSteps = 0;
    let start = [0, 0];

    for (const [height, x, y] of trees) {
        const steps = bfs(start, [x, y]);
        if (steps === -1) return -1;
        totalSteps += steps;
        start = [x, y];
    }

    return totalSteps;
};