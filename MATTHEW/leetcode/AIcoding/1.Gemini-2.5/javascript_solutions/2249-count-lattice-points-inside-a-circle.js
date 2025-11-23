var countLatticePoints = function(circles) {
    let minX = Infinity;
    let maxX = -Infinity;
    let minY = Infinity;
    let maxY = -Infinity;

    for (const [cx, cy, r] of circles) {
        minX = Math.min(minX, cx - r);
        maxX = Math.max(maxX, cx + r);
        minY = Math.min(minY, cy - r);
        maxY = Math.max(maxY, cy + r);
    }

    const latticePoints = new Set();

    for (let x = minX; x <= maxX; x++) {
        for (let y = minY; y <= maxY; y++) {
            for (const [cx, cy, r] of circles) {
                const dx = x - cx;
                const dy = y - cy;
                if (dx * dx + dy * dy <= r * r) {
                    latticePoints.add(`${x},${y}`);
                    break; 
                }
            }
        }
    }

    return latticePoints.size;
};