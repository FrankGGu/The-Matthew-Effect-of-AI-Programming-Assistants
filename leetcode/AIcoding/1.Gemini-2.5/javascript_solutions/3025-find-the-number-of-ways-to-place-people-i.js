var numberOfWays = function(points) {
    let count = 0;
    const n = points.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) {
                continue;
            }

            const p1 = points[i];
            const p2 = points[j];

            if (p1[0] >= p2[0] && p1[1] >= p2[1]) {
                count++;
            }
        }
    }

    return count;
};