var minAreaFreeRect = function(points) {
    const pointSet = new Set();
    points.forEach(point => pointSet.add(point.join(',')));
    let minArea = Infinity;

    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            const x1 = points[i][0], y1 = points[i][1];
            const x2 = points[j][0], y2 = points[j][1];
            const midX = (x1 + x2) / 2, midY = (y1 + y2) / 2;
            const dx = (x2 - x1) / 2, dy = (y2 - y1) / 2;

            const p3 = [midX - dy, midY + dx];
            const p4 = [midX + dy, midY - dx];

            if (pointSet.has(p3.join(',')) && pointSet.has(p4.join(','))) {
                const area = Math.abs(dx * 2 * dy * 2);
                minArea = Math.min(minArea, area);
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};