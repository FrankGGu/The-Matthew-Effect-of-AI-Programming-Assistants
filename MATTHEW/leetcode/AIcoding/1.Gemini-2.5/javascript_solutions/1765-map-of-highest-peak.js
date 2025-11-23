var highestPeak = function(isWater) {
    const m = isWater.length;
    const n = isWater[0].length;
    const height = Array(m).fill(0).map(() => Array(n).fill(-1));
    const queue = [];

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (isWater[r][c] === 1) {
                height[r][c] = 0;
                queue.push([r, c]);
            }
        }
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    let head = 0;

    while (head < queue.length) {
        const [r, c] = queue[head++];

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && height[nr][nc] === -1) {
                height[nr][nc] = height[r][c] + 1;
                queue.push([nr, nc]);
            }
        }
    }

    return height;
};