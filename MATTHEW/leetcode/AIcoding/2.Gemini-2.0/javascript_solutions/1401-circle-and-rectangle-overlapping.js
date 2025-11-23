var checkOverlap = function(radius, xCenter, yCenter, x1, y1, x2, y2) {
    let closestX = xCenter;
    let closestY = yCenter;

    if (xCenter < x1) {
        closestX = x1;
    } else if (xCenter > x2) {
        closestX = x2;
    }

    if (yCenter < y1) {
        closestY = y1;
    } else if (yCenter > y2) {
        closestY = y2;
    }

    const distanceX = xCenter - closestX;
    const distanceY = yCenter - closestY;

    const distanceSquared = (distanceX * distanceX) + (distanceY * distanceY);
    return distanceSquared <= (radius * radius);
};