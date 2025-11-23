var minAreaRect = function(points) {
    let minArea = Infinity;
    const pointSet = new Set();
    for (const point of points) {
        pointSet.add(`${point[0]},${point[1]}`);
    }

    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            const p1 = points[i];
            const p2 = points[j];

            if (p1[0] === p2[0] || p1[1] === p2[1]) {
                continue;
            }

            const p3_str = `${p1[0]},${p2[1]}`;
            const p4_str = `${p2[0]},${p1[1]}`;

            if (pointSet.has(p3_str) && pointSet.has(p4_str)) {
                const area = Math.abs(p1[0] - p2[0]) * Math.abs(p1[1] - p2[1]);
                minArea = Math.min(minArea, area);
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};