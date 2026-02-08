var bestCoordinate = function(towers, radius) {
    let maxX = 0, maxY = 0;
    for (const [x, y] of towers) {
        maxX = Math.max(maxX, x);
        maxY = Math.max(maxY, y);
    }

    let bestX = 0, bestY = 0, bestQuality = 0;

    for (let x = 0; x <= maxX; x++) {
        for (let y = 0; y <= maxY; y++) {
            let quality = 0;
            for (const [tx, ty, q] of towers) {
                const dist = Math.sqrt((tx - x) ** 2 + (ty - y) ** 2);
                if (dist <= radius) {
                    quality += Math.floor(q / (1 + dist));
                }
            }
            if (quality > bestQuality || (quality === bestQuality && (x < bestX || (x === bestX && y < bestY)))) {
                bestQuality = quality;
                bestX = x;
                bestY = y;
            }
        }
    }

    return [bestX, bestY];
};