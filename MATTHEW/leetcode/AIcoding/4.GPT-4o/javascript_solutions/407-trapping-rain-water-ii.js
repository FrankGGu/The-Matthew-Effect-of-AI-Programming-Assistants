var trapRainWater = function(heightMap) {
    if (!heightMap || heightMap.length === 0 || heightMap[0].length === 0) return 0;

    const m = heightMap.length, n = heightMap[0].length;
    const visited = Array.from({ length: m }, () => Array(n).fill(false));
    const minHeap = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 || j === 0 || i === m - 1 || j === n - 1) {
                visited[i][j] = true;
                minHeap.push([heightMap[i][j], i, j]);
            }
        }
    }

    minHeap.sort((a, b) => a[0] - b[0]);
    let waterTrapped = 0;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    while (minHeap.length > 0) {
        const [height, x, y] = minHeap.shift();

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                visited[nx][ny] = true;
                waterTrapped += Math.max(0, height - heightMap[nx][ny]);
                minHeap.push([Math.max(height, heightMap[nx][ny]), nx, ny]);
            }
        }

        minHeap.sort((a, b) => a[0] - b[0]);
    }

    return waterTrapped;
};