function maxAreaOfDiagonalRectangle(points) {
    let maxArea = 0;
    const n = points.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const x1 = points[i][0], y1 = points[i][1];
            const x2 = points[j][0], y2 = points[j][1];
            const width = Math.abs(x2 - x1);
            const height = Math.abs(y2 - y1);
            const area = width * height;
            maxArea = Math.max(maxArea, area);
        }
    }

    return maxArea;
}