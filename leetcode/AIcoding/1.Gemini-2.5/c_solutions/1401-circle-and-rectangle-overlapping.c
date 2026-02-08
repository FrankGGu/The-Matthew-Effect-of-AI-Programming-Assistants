#include <stdbool.h>
#include <math.h>

bool checkOverlap(int radius, int x_center, int y_center, int x1, int y1, int x2, int y2) {
    long long closestX = x_center;
    long long closestY = y_center;

    if (closestX < x1) {
        closestX = x1;
    } else if (closestX > x2) {
        closestX = x2;
    }

    if (closestY < y1) {
        closestY = y1;
    } else if (closestY > y2) {
        closestY = y2;
    }

    long long dx = x_center - closestX;
    long long dy = y_center - closestY;

    long long distanceSq = dx * dx + dy * dy;
    long long radiusSq = (long long)radius * radius;

    return distanceSq <= radiusSq;
}