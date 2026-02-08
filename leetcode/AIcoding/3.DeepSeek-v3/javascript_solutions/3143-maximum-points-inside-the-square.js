var maxPointsInsideSquare = function(points, s) {
    let minAbs = Infinity;
    const seen = new Map();

    for (const [x, y] of points) {
        const maxCoord = Math.max(Math.abs(x), Math.abs(y));
        if (seen.has(maxCoord)) {
            const existing = seen.get(maxCoord);
            if (existing === 0) {
                minAbs = Math.min(minAbs, maxCoord);
            }
            seen.set(maxCoord, existing + 1);
        } else {
            seen.set(maxCoord, 1);
        }
    }

    let count = 0;
    const sortedCoords = Array.from(seen.keys()).sort((a, b) => a - b);
    for (const coord of sortedCoords) {
        if (coord >= minAbs) break;
        count += seen.get(coord);
    }

    return count;
};