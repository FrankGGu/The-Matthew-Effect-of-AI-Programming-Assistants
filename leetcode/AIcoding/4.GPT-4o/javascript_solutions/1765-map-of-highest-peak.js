function highestPeak(isWater) {
    const rows = isWater.length;
    const cols = isWater[0].length;
    const height = Array.from({ length: rows }, () => Array(cols).fill(-1));
    const queue = [];

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (isWater[r][c] === 1) {
                height[r][c] = 0;
                queue.push([r, c]);
            }
        }
    }

    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    while (queue.length > 0) {
        const [r, c] = queue.shift();
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && height[nr][nc] === -1) {
                height[nr][nc] = height[r][c] + 1;
                queue.push([nr, nc]);
            }
        }
    }

    return height;
}