var minAreaRect = function(points) {
    const n = points.length;
    let minArea = Infinity;
    const pointSet = new Set();

    for (const [x, y] of points) {
        pointSet.add(`${x},${y}`);
    }

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const [x1, y1] = points[i];
            const [x2, y2] = points[j];

            if (x1 === x2 || y1 === y2) {
                continue;
            }

            if (pointSet.has(`${x1},${y2}`) && pointSet.has(`${x2},${y1}`)) {
                const area = Math.abs(x1 - x2) * Math.abs(y1 - y2);
                minArea = Math.min(minArea, area);
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};