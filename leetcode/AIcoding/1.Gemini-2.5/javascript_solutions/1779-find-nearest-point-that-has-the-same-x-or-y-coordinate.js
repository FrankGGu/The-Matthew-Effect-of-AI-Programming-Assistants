var nearestValidPoint = function(x, y, points) {
    let minDistance = Infinity;
    let minIndex = -1;

    for (let i = 0; i < points.length; i++) {
        const [px, py] = points[i];

        if (px === x || py === y) {
            const currentDistance = Math.abs(x - px) + Math.abs(y - py);

            if (currentDistance < minDistance) {
                minDistance = currentDistance;
                minIndex = i;
            }
        }
    }

    return minIndex;
};