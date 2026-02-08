int checkOverlap(int radius, int xCenter, int yCenter, int x1, int y1, int x2, int y2) {
    int closestX = (xCenter < x1) ? x1 : (xCenter > x2) ? x2 : xCenter;
    int closestY = (yCenter < y1) ? y1 : (yCenter > y2) ? y2 : yCenter;

    int distX = xCenter - closestX;
    int distY = yCenter - closestY;

    return (distX * distX + distY * distY) <= (radius * radius);
}