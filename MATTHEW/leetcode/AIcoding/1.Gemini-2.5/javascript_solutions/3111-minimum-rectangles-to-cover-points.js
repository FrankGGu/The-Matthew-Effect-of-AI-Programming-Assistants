var minRectanglesToCoverPoints = function(points, w) {
    points.sort((a, b) => a[0] - b[0]);

    let rectanglesCount = 0;
    let lastCoveredX = -Infinity; 

    for (let i = 0; i < points.length; i++) {
        const x = points[i][0];
        if (x > lastCoveredX) {
            rectanglesCount++;
            lastCoveredX = x + w;
        }
    }

    return rectanglesCount;
};