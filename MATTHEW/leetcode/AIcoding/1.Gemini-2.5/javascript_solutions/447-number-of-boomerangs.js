var numberOfBoomerangs = function(points) {
    let count = 0;

    for (let i = 0; i < points.length; i++) {
        const distances = new Map();
        for (let j = 0; j < points.length; j++) {
            if (i === j) {
                continue;
            }

            const dx = points[i][0] - points[j][0];
            const dy = points[i][1] - points[j][1];
            const distSq = dx * dx + dy * dy;

            distances.set(distSq, (distances.get(distSq) || 0) + 1);
        }

        for (const [distSq, freq] of distances.entries()) {
            if (freq >= 2) {
                count += freq * (freq - 1);
            }
        }
    }

    return count;
};