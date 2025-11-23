var minTimeToVisitAllPoints = function(points) {
    let time = 0;
    for (let i = 0; i < points.length - 1; i++) {
        let xDiff = Math.abs(points[i+1][0] - points[i][0]);
        let yDiff = Math.abs(points[i+1][1] - points[i][1]);
        time += Math.max(xDiff, yDiff);
    }
    return time;
};