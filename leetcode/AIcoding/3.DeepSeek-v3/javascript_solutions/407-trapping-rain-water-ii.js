var trapRainWater = function(heightMap) {
    if (heightMap.length === 0 || heightMap[0].length === 0) return 0;
    const m = heightMap.length;
    const n = heightMap[0].length;
    const visited = Array.from({ length: m }, () => new Array(n).fill(false));
    const minHeap = new MinPriorityQueue({ priority: (x) => x[2] });
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (let i = 0; i < m; i++) {
        visited[i][0] = true;
        visited[i][n - 1] = true;
        minHeap.enqueue([i, 0, heightMap[i][0]]);
        minHeap.enqueue([i, n - 1, heightMap[i][n - 1]]);
    }

    for (let j = 1; j < n - 1; j++) {
        visited[0][j] = true;
        visited[m - 1][j] = true;
        minHeap.enqueue([0, j, heightMap[0][j]]);
        minHeap.enqueue([m - 1, j, heightMap[m - 1][j]]);
    }

    let res = 0;
    while (!minHeap.isEmpty()) {
        const [i, j, h] = minHeap.dequeue().element;
        for (const [di, dj] of dirs) {
            const ni = i + di;
            const nj = j + dj;
            if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                visited[ni][nj] = true;
                res += Math.max(0, h - heightMap[ni][nj]);
                minHeap.enqueue([ni, nj, Math.max(h, heightMap[ni][nj])]);
            }
        }
    }
    return res;
};