function containVirus(warehouses) {
    const m = warehouses.length;
    const n = warehouses[0].length;

    function dfs(i, j, visited, area, virus) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || warehouses[i][j] === 0) {
            return;
        }
        visited[i][j] = true;
        area.push([i, j]);
        virus.push([i, j]);
        dfs(i + 1, j, visited, area, virus);
        dfs(i - 1, j, visited, area, virus);
        dfs(i, j + 1, visited, area, virus);
        dfs(i, j - 1, visited, area, virus);
    }

    function getBoundary(area) {
        const boundary = new Set();
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [i, j] of area) {
            for (const [dx, dy] of directions) {
                const ni = i + dx;
                const nj = j + dy;
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && warehouses[ni][nj] === 0) {
                    boundary.add(`${ni},${nj}`);
                }
            }
        }
        return boundary;
    }

    let result = 0;

    while (true) {
        const visited = Array.from({ length: m }, () => Array(n).fill(false));
        const areas = [];
        const boundaries = [];

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (!visited[i][j] && warehouses[i][j] === 1) {
                    const area = [];
                    const virus = [];
                    dfs(i, j, visited, area, virus);
                    const boundary = getBoundary(area);
                    areas.push(area);
                    boundaries.push(boundary);
                }
            }
        }

        if (areas.length === 0) break;

        let maxIndex = 0;
        let maxBoundary = boundaries[0];
        for (let i = 1; i < boundaries.length; i++) {
            if (boundaries[i].size > maxBoundary.size) {
                maxIndex = i;
                maxBoundary = boundaries[i];
            }
        }

        for (const [i, j] of areas[maxIndex]) {
            warehouses[i][j] = 0;
        }

        result += maxBoundary.size;

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (warehouses[i][j] === 1) {
                    for (const [di, dj] of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                        const ni = i + di;
                        const nj = j + dj;
                        if (ni >= 0 && ni < m && nj >= 0 && nj < n && warehouses[ni][nj] === 0) {
                            warehouses[ni][nj] = 2;
                        }
                    }
                }
            }
        }
    }

    return result;
}