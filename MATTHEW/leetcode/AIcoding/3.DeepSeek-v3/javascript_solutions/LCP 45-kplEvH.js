var bicycleYard = function(terrain, obstacle) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const m = terrain.length;
    const n = terrain[0].length;
    const visited = new Array(m).fill(0).map(() => new Array(n).fill(0).map(() => new Set()));
    const res = [];
    const queue = [];

    queue.push([0, 0, 1]);
    visited[0][0].add(1);

    while (queue.length > 0) {
        const [i, j, speed] = queue.shift();

        for (const [di, dj] of directions) {
            const ni = i + di;
            const nj = j + dj;

            if (ni < 0 || ni >= m || nj < 0 || nj >= n) continue;

            const delta = terrain[i][j] - terrain[ni][nj];
            const newSpeed = speed + delta - obstacle[ni][nj];

            if (newSpeed <= 0) continue;
            if (visited[ni][nj].has(newSpeed)) continue;

            visited[ni][nj].add(newSpeed);
            queue.push([ni, nj, newSpeed]);

            if (newSpeed === 1) {
                res.push([ni, nj]);
            }
        }
    }

    res.sort((a, b) => a[0] === b[0] ? a[1] - b[1] : a[0] - b[0]);
    return res;
};