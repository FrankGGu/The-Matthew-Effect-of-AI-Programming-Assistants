function isPerfectRectangle(rectangles) {
    const area = rectangles.reduce((sum, [x1, y1, x2, y2]) => sum + (x2 - x1) * (y2 - y1), 0);
    const points = new Set();
    const corners = [[0, 0], [0, 1], [1, 0], [1, 1]];
    for (const [x1, y1, x2, y2] of rectangles) {
        for (const [dx, dy] of corners) {
            const key = `${x1 + dx * (x2 - x1)}-${y1 + dy * (y2 - y1)}`;
            if (points.has(key)) {
                points.delete(key);
            } else {
                points.add(key);
            }
        }
    }
    if (points.size !== 4) return false;
    const [minX, minY] = [...points].map(p => p.split('-').map(Number)).sort((a, b) => a[0] - b[0] || a[1] - b[1])[0];
    const [maxX, maxY] = [...points].map(p => p.split('-').map(Number)).sort((a, b) => b[0] - a[0] || b[1] - a[1])[0];
    return (maxX - minX) * (maxY - minY) === area;
}