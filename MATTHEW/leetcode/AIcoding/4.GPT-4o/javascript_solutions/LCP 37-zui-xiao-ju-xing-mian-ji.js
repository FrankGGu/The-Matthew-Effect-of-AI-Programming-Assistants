function minAreaRect(points) {
    const pointSet = new Set(points.map(point => point.join(',')));
    let minArea = Infinity;

    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            if (points[i][0] !== points[j][0] && points[i][1] !== points[j][1]) {
                const x1 = points[i][0];
                const y1 = points[i][1];
                const x2 = points[j][0];
                const y2 = points[j][1];

                if (pointSet.has(`${x1},${y2}`) && pointSet.has(`${x2},${y1}`)) {
                    const area = Math.abs(x1 - x2) * Math.abs(y1 - y2);
                    minArea = Math.min(minArea, area);
                }
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
}