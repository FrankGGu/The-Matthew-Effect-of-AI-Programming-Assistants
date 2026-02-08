var nearestValidPoint = function(x, y, points) {
    let minDistance = Infinity;
    let nearestIndex = -1;

    for (let i = 0; i < points.length; i++) {
        const point = points[i];
        if (point[0] === x || point[1] === y) {
            const distance = Math.abs(point[0] - x) + Math.abs(point[1] - y);
            if (distance < minDistance) {
                minDistance = distance;
                nearestIndex = i;
            }
        }
    }

    return nearestIndex;
};