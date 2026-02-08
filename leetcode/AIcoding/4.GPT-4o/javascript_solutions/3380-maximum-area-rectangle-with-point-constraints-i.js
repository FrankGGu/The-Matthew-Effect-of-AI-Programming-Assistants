function maxAreaRect(points) {
    const pointSet = new Set(points.map(p => p.join(',')));
    let maxArea = 0;

    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            if (points[i][0] !== points[j][0] && points[i][1] !== points[j][1]) {
                const bottomLeft = [points[i][0], points[j][1]];
                const topRight = [points[j][0], points[i][1]];
                if (pointSet.has(bottomLeft.join(',')) && pointSet.has(topRight.join(','))) {
                    const area = Math.abs(points[i][0] - points[j][0]) * Math.abs(points[i][1] - points[j][1]);
                    maxArea = Math.max(maxArea, area);
                }
            }
        }
    }

    return maxArea;
}