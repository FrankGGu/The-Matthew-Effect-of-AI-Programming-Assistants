#include <stdlib.h>

struct Point {
    int x;
    int y;
};

int maxPoints(struct Point* points, int pointsSize) {
    if (pointsSize < 3) return pointsSize;

    int maxResult = 0;
    for (int i = 0; i < pointsSize; i++) {
        int samePointCount = 1;
        int maxCount = 0;
        int slopeCount[2000] = {0};

        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i].x == points[j].x && points[i].y == points[j].y) {
                samePointCount++;
                continue;
            }

            int dx = points[j].x - points[i].x;
            int dy = points[j].y - points[i].y;
            int gcd = abs(dy) == 0 ? abs(dx) : (dy > 0 ? dy : -dy);
            dx /= gcd;
            dy /= gcd;

            if (dx < 0) {
                dx = -dx;
                dy = -dy;
            }

            slopeCount[dy * 1000 + dx]++;
            maxCount = maxCount > slopeCount[dy * 1000 + dx] ? maxCount : slopeCount[dy * 1000 + dx];
        }

        maxResult = maxResult > maxCount + samePointCount ? maxResult : maxCount + samePointCount;
    }

    return maxResult;
}