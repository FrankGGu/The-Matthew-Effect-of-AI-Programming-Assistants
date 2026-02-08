bool checkOverlap(int circleX, int circleY, int radius, int rectX1, int rectY1, int rectX2, int rectY2) {
    int closestX = fmax(rectX1, fmin(circleX, rectX2));
    int closestY = fmax(rectY1, fmin(circleY, rectY2));

    int distanceX = circleX - closestX;
    int distanceY = circleY - closestY;

    return (distanceX * distanceX + distanceY * distanceY) <= (radius * radius);
}