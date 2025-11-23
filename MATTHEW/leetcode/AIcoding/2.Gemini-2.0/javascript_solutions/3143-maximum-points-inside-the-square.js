var maxPointsInsideSquare = function(points, sideLength) {
    let maxPoints = 0;
    for (let i = 0; i < points.length; i++) {
        for (let j = 0; j < points.length; j++) {
            let x = points[i][0];
            let y = points[j][1];
            let count = 0;
            for (let k = 0; k < points.length; k++) {
                if (points[k][0] >= x && points[k][0] <= x + sideLength &&
                    points[k][1] >= y && points[k][1] <= y + sideLength) {
                    count++;
                }
            }
            maxPoints = Math.max(maxPoints, count);
        }
    }
    return maxPoints;
};