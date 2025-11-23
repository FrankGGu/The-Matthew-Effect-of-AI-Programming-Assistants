var checkOverlap = function(radius, x_center, y_center, x1, y1, x2, y2) {
    let closestX = Math.max(x1, Math.min(x_center, x2));
    let closestY = Math.max(y1, Math.min(y_center, y2));

    let distX = x_center - closestX;
    let distY = y_center - closestY;

    let distanceSq = (distX * distX) + (distY * distY);

    return distanceSq <= (radius * radius);
};