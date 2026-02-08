function cutOffTree(forest) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const rows = forest.length, cols = forest[0].length;

    const bfs = (start, target) => {
        const queue = [start];
        const visited = new Set();
        visited.add(start.join(','));
        let steps = 0;

        while (queue.length) {
            let size = queue.length;
            for (let i = 0; i < size; i++) {
                const [x, y] = queue.shift();
                if (x === target[0] && y === target[1]) return steps;

                for (const [dx, dy] of directions) {
                    const nx = x + dx, ny = y + dy;
                    if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && forest[nx][ny] > 0 && !visited.has(`${nx},${ny}`)) {
                        visited.add(`${nx},${ny}`);
                        queue.push([nx, ny]);
                    }
                }
            }
            steps++;
        }
        return -1;
    };

    const trees = [];
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (forest[i][j] > 1) {
                trees.push([forest[i][j], i, j]);
            }
        }
    }

    trees.sort((a, b) => a[0] - b[0]);

    let totalSteps = 0;
    let currentPos = [0, 0];

    for (const [height, x, y] of trees) {
        const steps = bfs(currentPos, [x, y]);
        if (steps === -1) return -1;
        totalSteps += steps;
        currentPos = [x, y];
    }

    return totalSteps;
}