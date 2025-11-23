var minTimeToVisitAllPoints = function(points) {
    let totalTime = 0;
    for (let i = 1; i < points.length; i++) {
        const p1 = points[i - 1];
        const p2 = points[i];
        const dx = Math.abs(p2[0] - p1[0]);
        const dy = Math.abs(p2[1] - p1[1]);
        totalTime += Math.max(dx, dy);
    }
    return totalTime;
};