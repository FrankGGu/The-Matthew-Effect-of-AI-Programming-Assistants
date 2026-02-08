var minimalSteps = function(target) {
    const m = target.length;
    if (m === 0) return 0;
    const n = target[0].length;
    if (n === 0) return 0;

    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const queue = [];
    const visited = new Array(m).fill(0).map(() => new Array(n).fill(false));

    queue.push([0, 0]);
    visited[0][0] = true;
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [x, y] = queue.shift();
            if (x === m - 1 && y === n - 1) {
                return steps;
            }
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && target[nx][ny] === 0) {
                    visited[nx][ny] = true;
                    queue.push([nx, ny]);
                }
            }
        }
        steps++;
    }

    return -1;
};