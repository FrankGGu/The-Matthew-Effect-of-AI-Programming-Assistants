var isRectangleCover = function(rectangles) {
    if (rectangles.length === 0) return false;

    let x1 = Infinity, y1 = Infinity, x2 = -Infinity, y2 = -Infinity;
    let area = 0;
    const points = new Set();

    for (const [a, b, c, d] of rectangles) {
        x1 = Math.min(x1, a);
        y1 = Math.min(y1, b);
        x2 = Math.max(x2, c);
        y2 = Math.max(y2, d);

        area += (c - a) * (d - b);

        const p1 = `${a},${b}`;
        const p2 = `${a},${d}`;
        const p3 = `${c},${b}`;
        const p4 = `${c},${d}`;

        [p1, p2, p3, p4].forEach(p => {
            if (points.has(p)) points.delete(p);
            else points.add(p);
        });
    }

    const expectedArea = (x2 - x1) * (y2 - y1);
    if (area !== expectedArea) return false;

    if (points.size !== 4) return false;

    const corners = [
        `${x1},${y1}`,
        `${x1},${y2}`,
        `${x2},${y1}`,
        `${x2},${y2}`
    ];

    for (const corner of corners) {
        if (!points.has(corner)) return false;
    }

    return true;
};