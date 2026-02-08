var minArea = function(image, x, y) {
    let minX = x, maxX = x, minY = y, maxY = y;
    const m = image.length, n = image[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (image[i][j] === '1') {
                minX = Math.min(minX, i);
                maxX = Math.max(maxX, i);
                minY = Math.min(minY, j);
                maxY = Math.max(maxY, j);
            }
        }
    }

    return (maxX - minX + 1) * (maxY - minY + 1);
};