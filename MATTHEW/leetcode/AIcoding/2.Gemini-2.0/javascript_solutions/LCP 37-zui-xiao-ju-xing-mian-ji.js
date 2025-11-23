var minAreaRect = function(points) {
    const n = points.length;
    if (n < 4) return 0;

    let minArea = Infinity;
    const pointSet = new Set();
    for (const point of points) {
        pointSet.add(point[0] + "," + point[1]);
    }

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const p1 = points[i];
            const p2 = points[j];

            if (p1[0] === p2[0] || p1[1] === p2[1]) continue;

            const p3_x = p1[0];
            const p3_y = p2[1];
            const p4_x = p2[0];
            const p4_y = p1[1];

            if (pointSet.has(p3_x + "," + p3_y) && pointSet.has(p4_x + "," + p4_y)) {
                const area = Math.abs(p1[0] - p2[0]) * Math.abs(p1[1] - p2[1]);
                minArea = Math.min(minArea, area);
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};