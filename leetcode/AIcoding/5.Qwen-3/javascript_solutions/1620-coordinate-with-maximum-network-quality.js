function bestCoordinate(towers, radius) {
    const n = towers.length;
    let maxQuality = 0;
    let bestCoord = [0, 0];

    for (let x = 0; x <= 50; x++) {
        for (let y = 0; y <= 50; y++) {
            let totalQuality = 0;
            for (const [tx, ty, q] of towers) {
                const dx = x - tx;
                const dy = y - ty;
                const distance = Math.sqrt(dx * dx + dy * dy);
                if (distance <= radius) {
                    totalQuality += Math.floor(q / (distance + 1));
                }
            }
            if (totalQuality > maxQuality) {
                maxQuality = totalQuality;
                bestCoord = [x, y];
            }
        }
    }

    return bestCoord;
}