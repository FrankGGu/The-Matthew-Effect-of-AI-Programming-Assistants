var trapRainWater = function(heightMap) {
    if (!heightMap || heightMap.length === 0 || heightMap[0].length === 0) {
        return 0;
    }

    const m = heightMap.length;
    const n = heightMap[0].length;
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));
    const pq = [];

    for (let i = 0; i < m; i++) {
        pq.push({row: i, col: 0, height: heightMap[i][0]});
        pq.push({row: i, col: n - 1, height: heightMap[i][n - 1]});
        visited[i][0] = true;
        visited[i][n - 1] = true;
    }

    for (let j = 1; j < n - 1; j++) {
        pq.push({row: 0, col: j, height: heightMap[0][j]});
        pq.push({row: m - 1, col: j, height: heightMap[m - 1][j]});
        visited[0][j] = true;
        visited[m - 1][j] = true;
    }

    pq.sort((a, b) => a.height - b.height);

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    let trappedWater = 0;

    while (pq.length > 0) {
        const cell = pq.shift();
        const row = cell.row;
        const col = cell.col;
        const height = cell.height;

        for (const dir of directions) {
            const newRow = row + dir[0];
            const newCol = col + dir[1];

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                visited[newRow][newCol] = true;
                trappedWater += Math.max(0, height - heightMap[newRow][newCol]);
                pq.push({row: newRow, col: newCol, height: Math.max(height, heightMap[newRow][newCol])});
                pq.sort((a, b) => a.height - b.height);
            }
        }
    }

    return trappedWater;
};