function imageSmoother(img) {
    const rows = img.length;
    const cols = img[0].length;
    const result = Array.from({ length: rows }, () => Array(cols).fill(0));

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],  [0, 0],  [0, 1],
        [1, -1],  [1, 0],  [1, 1]
    ];

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            let sum = 0, count = 0;
            for (const [dr, dc] of directions) {
                const nr = r + dr, nc = c + dc;
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                    sum += img[nr][nc];
                    count++;
                }
            }
            result[r][c] = Math.floor(sum / count);
        }
    }

    return result;
}