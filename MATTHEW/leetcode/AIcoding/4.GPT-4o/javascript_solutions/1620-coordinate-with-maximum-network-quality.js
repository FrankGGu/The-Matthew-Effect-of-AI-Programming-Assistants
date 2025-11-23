var bestCoordinate = function(towers, radius) {
    const points = [];
    const maxQuality = [0, 0, 0]; // [quality, x, y]

    for (const [x1, y1, q] of towers) {
        for (let x = Math.max(0, x1 - radius); x <= x1 + radius; x++) {
            for (let y = Math.max(0, y1 - radius); y <= y1 + radius; y++) {
                const distance = Math.sqrt((x1 - x) ** 2 + (y1 - y) ** 2);
                if (distance <= radius) {
                    if (!points[x]) points[x] = {};
                    if (!points[x][y]) points[x][y] = 0;
                    points[x][y] += (q - Math.floor(distance));
                }
            }
        }
    }

    for (const [x, ys] of Object.entries(points)) {
        for (const [y, quality] of Object.entries(ys)) {
            if (quality > maxQuality[0] || (quality === maxQuality[0] && (x > maxQuality[1] || (x == maxQuality[1] && y > maxQuality[2])))) {
                maxQuality[0] = quality;
                maxQuality[1] = parseInt(x);
                maxQuality[2] = parseInt(y);
            }
        }
    }

    return [maxQuality[1], maxQuality[2]];
};