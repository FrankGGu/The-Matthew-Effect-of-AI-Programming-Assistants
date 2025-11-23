var minRectanglesToCoverPoints = function(points) {
    if (points.length === 0) return 0;

    points.sort((a, b) => a[0] - b[0]);

    let count = 1;
    let currentEnd = points[0][0];
    let maxY = points[0][1];
    let minY = points[0][1];

    for (let i = 1; i < points.length; i++) {
        const [x, y] = points[i];
        if (x <= currentEnd) {
            maxY = Math.max(maxY, y);
            minY = Math.min(minY, y);
        } else {
            count++;
            currentEnd = x;
            maxY = y;
            minY = y;
        }
    }

    return count;
};