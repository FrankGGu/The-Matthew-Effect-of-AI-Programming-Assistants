var getMinDistSum = function(points) {
    const n = points.length;

    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return 0;
    }

    const dist = (x1, y1, x2, y2) => Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));

    const calculateTotalDistance = (cx, cy) => {
        let total = 0;
        for (const p of points) {
            total += dist(cx, cy, p[0], p[1]);
        }
        return total;
    };

    let currentX = 0;
    let currentY = 0;

    for (const p of points) {
        currentX += p[0];
        currentY += p[1];
    }
    currentX /= n;
    currentY /= n;

    let minTotalDist = calculateTotalDistance(currentX, currentY);

    const dx = [0, 1, 1, 1, 0, -1, -1, -1];
    const dy = [1, 1, 0, -1, -1, -1, 0, 1];

    let step = 100.0;
    const iterations = 100;

    for (let i = 0; i < iterations; i++) {
        let improvedInThisIteration = false;
        for (let j = 0; j < 8; j++) {
            const nextX = currentX + dx[j] * step;
            const nextY = currentY + dy[j] * step;
            const newTotalDist = calculateTotalDistance(nextX, nextY);

            if (newTotalDist < minTotalDist) {
                minTotalDist = newTotalDist;
                currentX = nextX;
                currentY = nextY;
                improvedInThisIteration = true;
            }
        }
        step /= 2.0;
    }

    return minTotalDist;
};