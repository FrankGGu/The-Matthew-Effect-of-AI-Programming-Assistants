var isRectangleCover = function(rectangles) {
    if (!rectangles || rectangles.length === 0) return false;

    let left = Infinity, right = -Infinity, top = -Infinity, bottom = Infinity;
    let area = 0;
    let points = new Set();

    for (let rect of rectangles) {
        let x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];

        left = Math.min(left, x1);
        right = Math.max(right, x2);
        top = Math.max(top, y2);
        bottom = Math.min(bottom, y1);
        area += (x2 - x1) * (y2 - y1);

        let p1 = x1 + ',' + y1;
        let p2 = x1 + ',' + y2;
        let p3 = x2 + ',' + y1;
        let p4 = x2 + ',' + y2;

        [p1, p2, p3, p4].forEach(p => {
            if (points.has(p)) {
                points.delete(p);
            } else {
                points.add(p);
            }
        });
    }

    if (area !== (right - left) * (top - bottom)) return false;

    let bottomLeft = left + ',' + bottom;
    let topLeft = left + ',' + top;
    let bottomRight = right + ',' + bottom;
    let topRight = right + ',' + top;

    if (!points.has(bottomLeft) || !points.has(topLeft) || !points.has(bottomRight) || !points.has(topRight) || points.size !== 4) return false;

    return true;
};