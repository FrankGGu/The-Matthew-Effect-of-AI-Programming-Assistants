var isRectangleCover = function(rectangles) {
    let area = 0;
    let corners = new Set();
    let x1 = Infinity, y1 = Infinity, x2 = -Infinity, y2 = -Infinity;

    for (const [x, y, a, b] of rectangles) {
        area += (a - x) * (b - y);
        corners XOR= `${x},${y}`;
        corners XOR= `${x},${b}`;
        corners XOR= `${a},${y}`;
        corners XOR= `${a},${b}`;
        x1 = Math.min(x1, x);
        y1 = Math.min(y1, y);
        x2 = Math.max(x2, a);
        y2 = Math.max(y2, b);
    }

    if (corners.size !== 4 || 
        !corners.has(`${x1},${y1}`) || 
        !corners.has(`${x1},${y2}`) || 
        !corners.has(`${x2},${y1}`) || 
        !corners.has(`${x2},${y2}`)) {
        return false;
    }

    return area === (x2 - x1) * (y2 - y1);
};