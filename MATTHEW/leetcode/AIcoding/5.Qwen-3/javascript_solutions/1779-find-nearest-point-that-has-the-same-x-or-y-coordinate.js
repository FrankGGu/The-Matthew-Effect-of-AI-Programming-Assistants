var nearestValidPoint = function(x, y, points) {
    let minDistance = Infinity;
    let resultIndex = -1;

    for (let i = 0; i < points.length; i++) {
        const [px, py] = points[i];
        if (px === x || py === y) {
            const distance = Math.abs(px - x) + Math.abs(py - y);
            if (distance < minDistance) {
                minDistance = distance;
                resultIndex = i;
            }
        }
    }

    return resultIndex;
};