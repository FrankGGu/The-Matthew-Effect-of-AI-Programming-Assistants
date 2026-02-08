var isBoomerang = function(points) {
    const x1 = points[0][0];
    const y1 = points[0][1];
    const x2 = points[1][0];
    const y2 = points[1][1];
    const x3 = points[2][0];
    const y3 = points[2][1];

    // Check if any two points are identical
    if ((x1 === x2 && y1 === y2) ||
        (x1 === x3 && y1 === y3) ||
        (x2 === x3 && y2 === y3)) {
        return false;
    }

    // Check for collinearity using the cross product method (area of triangle)
    // If the expression is 0, the points are collinear.
    // We want them NOT to be collinear, so the expression must not be 0.
    return (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) !== 0;
};