function maxAreaRectangle(points) {
    const n = points.length;
    let maxArea = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const x1 = points[i][0];
            const y1 = points[i][1];
            const x2 = points[j][0];
            const y2 = points[j][1];

            if (x1 === x2 || y1 === y2) continue;

            const dx = Math.abs(x1 - x2);
            const dy = Math.abs(y1 - y2);

            for (let k = 0; k < n; k++) {
                if (k === i || k === j) continue;
                const x3 = points[k][0];
                const y3 = points[k][1];

                if ((x3 === x1 || x3 === x2) && (y3 === y1 || y3 === y2)) {
                    const area = dx * dy;
                    maxArea = Math.max(maxArea, area);
                }
            }
        }
    }

    return maxArea;
}