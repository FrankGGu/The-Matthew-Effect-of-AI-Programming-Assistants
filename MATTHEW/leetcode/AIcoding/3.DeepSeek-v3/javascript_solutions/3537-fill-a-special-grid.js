var fillGrid = function(m, n, positions) {
    const grid = new Array(m).fill().map(() => new Array(n).fill(0));
    const parent = new Array(m * n).fill().map((_, i) => i);
    const size = new Array(m * n).fill(1);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) return;
        if (size[rootU] > size[rootV]) {
            parent[rootV] = rootU;
            size[rootU] += size[rootV];
        } else {
            parent[rootU] = rootV;
            size[rootV] += size[rootU];
        }
    }

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const result = [];
    let count = 0;

    for (const [x, y] of positions) {
        if (grid[x][y] === 1) {
            result.push(count);
            continue;
        }
        grid[x][y] = 1;
        count++;
        const idx = x * n + y;
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] === 1) {
                const nIdx = nx * n + ny;
                if (find(idx) !== find(nIdx)) {
                    union(idx, nIdx);
                    count--;
                }
            }
        }
        result.push(count);
    }

    return result;
};