var nearestValidPoint = function(x, y, points) {
    let nearestIndex = -1;
    let minDistance = Infinity;

    for (let i = 0; i < points.length; i++) {
        const [px, py] = points[i];
        if (px === x || py === y) {
            const distance = Math.abs(px - x) + Math.abs(py - y);
            if (distance < minDistance) {
                minDistance = distance;
                nearestIndex = i;
            }
        }
    }

    return nearestIndex;
};