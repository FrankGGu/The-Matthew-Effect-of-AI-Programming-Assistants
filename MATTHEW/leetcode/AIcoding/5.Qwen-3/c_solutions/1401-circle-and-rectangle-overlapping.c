#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
    int radius;
} Circle;

typedef struct {
    int x1;
    int y1;
    int x2;
    int y2;
} Rectangle;

bool checkOverlap(Circle circle, Rectangle rectangle) {
    int rectCenterX = (rectangle.x1 + rectangle.x2) / 2;
    int rectCenterY = (rectangle.y1 + rectangle.y2) / 2;
    int rectHalfWidth = abs(rectangle.x2 - rectangle.x1) / 2;
    int rectHalfHeight = abs(rectangle.y2 - rectangle.y1) / 2;

    int dx = abs(circle.x - rectCenterX);
    int dy = abs(circle.y - rectCenterY);

    if (dx > rectHalfWidth + circle.radius || dy > rectHalfHeight + circle.radius) {
        return false;
    }

    if (dx <= rectHalfWidth || dy <= rectHalfHeight) {
        return true;
    }

    int dx2 = dx - rectHalfWidth;
    int dy2 = dy - rectHalfHeight;
    return (dx2 * dx2 + dy2 * dy2) <= (circle.radius * circle.radius);
}