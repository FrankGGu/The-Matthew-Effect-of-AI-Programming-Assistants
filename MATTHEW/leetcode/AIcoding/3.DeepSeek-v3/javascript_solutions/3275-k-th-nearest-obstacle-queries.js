var kthNearest = function(p, obstacles, k) {
    obstacles.sort((a, b) => {
        const distA = Math.abs(a[0] - p[0]) + Math.abs(a[1] - p[1]);
        const distB = Math.abs(b[0] - p[0]) + Math.abs(b[1] - p[1]);
        if (distA !== distB) {
            return distA - distB;
        } else if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            return a[1] - b[1];
        }
    });
    return obstacles[k - 1];
};