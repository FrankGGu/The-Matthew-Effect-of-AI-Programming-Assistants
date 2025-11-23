function countLatticePoints(rectangles) {
    const points = new Set();

    for (const [x1, y1, x2, y2] of rectangles) {
        for (let x = x1; x <= x2; x++) {
            for (let y = y1; y <= y2; y++) {
                points.add(`${x},${y}`);
            }
        }
    }

    return points.size;
}