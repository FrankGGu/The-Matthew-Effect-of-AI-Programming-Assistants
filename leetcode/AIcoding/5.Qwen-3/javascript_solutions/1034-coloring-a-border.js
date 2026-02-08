function colorBorder(image, r0, c0, color) {
    const rows = image.length;
    const cols = image[0].length;
    const originalColor = image[r0][c0];
    if (originalColor === color) return image;

    const queue = [[r0, c0]];
    const visited = new Set();
    visited.add(`${r0},${c0}`);

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (queue.length > 0) {
        const [r, c] = queue.shift();
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && image[nr][nc] === originalColor && !visited.has(`${nr},${nc}`)) {
                visited.add(`${nr},${nc}`);
                queue.push([nr, nc]);
            }
        }
    }

    for (const pos of visited) {
        const [r, c] = pos.split(',').map(Number);
        let isBorder = false;
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr < 0 || nr >= rows || nc < 0 || nc >= cols || image[nr][nc] !== originalColor) {
                isBorder = true;
                break;
            }
        }
        if (isBorder) {
            image[r][c] = color;
        }
    }

    return image;
}