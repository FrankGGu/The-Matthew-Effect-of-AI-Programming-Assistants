function countRectangles(rectangles, points) {
    const count = new Array(points.length).fill(0);
    const sortedRectangles = rectangles.sort((a, b) => a[1] - b[1]);

    for (let i = 0; i < points.length; i++) {
        const [px, py] = points[i];
        for (const [rx, ry] of sortedRectangles) {
            if (rx >= px && ry >= py) {
                count[i]++;
            }
        }
    }

    return count;
}