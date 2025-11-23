var nearestValidPoint = function(x, y, points) {
    let minDistance = Infinity;
    let minIndex = -1;

    for (let i = 0; i < points.length; i++) {
        const [xi, yi] = points[i];
        if (xi === x || yi === y) {
            const distance = Math.abs(xi - x) + Math.abs(yi - y);
            if (distance < minDistance) {
                minDistance = distance;
                minIndex = i;
            } else if (distance === minDistance && i < minIndex) {
                minIndex = i;
            }
        }
    }

    return minIndex;
};