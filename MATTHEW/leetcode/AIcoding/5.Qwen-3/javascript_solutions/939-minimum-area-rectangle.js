function minAreaRect(rectangles) {
    const points = new Set();
    for (const [x, y] of rectangles) {
        points.add(`${x},${y}`);
    }

    let minArea = Infinity;

    for (let i = 0; i < rectangles.length; i++) {
        const [x1, y1] = rectangles[i];
        for (let j = i + 1; j < rectangles.length; j++) {
            const [x2, y2] = rectangles[j];
            if (x1 !== x2 && y1 !== y2) {
                const p1 = `${x1},${y2}`;
                const p2 = `${x2},${y1}`;
                if (points.has(p1) && points.has(p2)) {
                    const area = Math.abs((x2 - x1) * (y2 - y1));
                    minArea = Math.min(minArea, area);
                }
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
}