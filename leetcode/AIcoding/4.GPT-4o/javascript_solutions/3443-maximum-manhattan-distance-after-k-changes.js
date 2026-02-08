var maxDistance = function(points, K) {
    let n = points.length;
    let maxDist = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let distance = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);
            if (K >= Math.abs(i - j)) {
                maxDist = Math.max(maxDist, distance);
            }
        }
    }

    return maxDist;
};