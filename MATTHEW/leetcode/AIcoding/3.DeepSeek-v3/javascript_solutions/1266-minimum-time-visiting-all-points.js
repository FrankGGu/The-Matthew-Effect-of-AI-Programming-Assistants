var minTimeToVisitAllPoints = function(points) {
    let time = 0;
    for (let i = 1; i < points.length; i++) {
        const [x1, y1] = points[i - 1];
        const [x2, y2] = points[i];
        const dx = Math.abs(x2 - x1);
        const dy = Math.abs(y2 - y1);
        time += Math.max(dx, dy);
    }
    return time;
};