var largestTriangleArea = function(points) {
    let maxArea = 0;
    const n = points.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                const p1 = points[i];
                const p2 = points[j];
                const p3 = points[k];

                const x1 = p1[0], y1 = p1[1];
                const x2 = p2[0], y2 = p2[1];
                const x3 = p3[0], y3 = p3[1];

                const currentArea = 0.5 * Math.abs(x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2));
                maxArea = Math.max(maxArea, currentArea);
            }
        }
    }

    return maxArea;
};