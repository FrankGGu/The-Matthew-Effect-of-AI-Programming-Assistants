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

            const x1 = p1[0];
            const y1 = p1[1];
            const x2 = p2[0];
            const y2 = p2[1];

            // If x-coordinates or y-coordinates are the same,
            // these points cannot be diagonal corners of a rectangle with positive area.
            if (x1 === x2 || y1 === y2) {
                continue;
            }

            // The other two potential corners of the rectangle would be (x1, y2) and (x2, y1).
            // Check if these points exist in the given set of points.
            const p3Str = `${x1},${y2}`;
            const p4Str = `${x2},${y1}`;

            if (pointSet.has(p3Str) && pointSet.has(p4Str)) {
                // A rectangle is found. Calculate its area.
                const currentArea = Math.abs(x1 - x2) * Math.abs(y1 - y2);
                minArea = Math.min(minArea, currentArea);
            }
        }
    }

    // If minArea is still Infinity, no rectangle was found.
    return minArea === Infinity ? 0 : minArea;
};