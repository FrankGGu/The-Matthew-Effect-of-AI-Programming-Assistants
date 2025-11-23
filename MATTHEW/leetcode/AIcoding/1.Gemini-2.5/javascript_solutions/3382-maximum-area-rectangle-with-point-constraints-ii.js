var maxAreaRectangleWithPointConstraintsII = function(points) {
    let maxArea = 0;
    const pointSet = new Set();
    for (const [x, y] of points) {
        pointSet.add(`${x},${y}`);
    }

    points.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    for (let i = 0; i < points.length; i++) {
        const p1 = points[i];
        for (let j = i + 1; j < points.length; j++) {
            const p2 = points[j];

            if (p1[0] === p2[0] || p1[1] === p2[1]) {
                continue;
            }

            const p3_x = p1[0];
            const p3_y = p2[1];
            const p4_x = p2[0];
            const p4_y = p1[1];

            if (pointSet.has(`${p3_x},${p3_y}`) && pointSet.has(`${p4_x},${p4_y}`)) {
                const currentArea = Math.abs(p1[0] - p2[0]) * Math.abs(p1[1] - p2[1]);
                maxArea = Math.max(maxArea, currentArea);
            }
        }
    }

    return maxArea;
};