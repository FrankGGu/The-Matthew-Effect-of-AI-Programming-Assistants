var bestCoordinate = function(towers, radius) {
    let maxQuality = -1;
    let bestCoord = [0, 0];

    for (let x = 0; x <= 50; x++) {
        for (let y = 0; y <= 50; y++) {
            let totalQuality = 0;
            for (const [tx, ty, tq] of towers) {
                const distance = Math.sqrt((tx - x) ** 2 + (ty - y) ** 2);
                if (distance <= radius) {
                    totalQuality += Math.floor(tq / (1 + distance));
                }
            }
            if (totalQuality > maxQuality) {
                maxQuality = totalQuality;
                bestCoord = [x, y];
            } else if (totalQuality === maxQuality) {
                if (x < bestCoord[0] || (x === bestCoord[0] && y < bestCoord[1])) {
                    bestCoord = [x, y];
                }
            }
        }
    }

    return bestCoord;
};