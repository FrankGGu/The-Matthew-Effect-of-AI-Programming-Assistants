#include <math.h>
#include <stdlib.h>

#define MAX_POINTS 500

typedef struct {
    double x;
    double y;
} Point;

double distance(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

Point getCircleCenter(Point a, Point b, double r) {
    Point mid = {(a.x + b.x) / 2.0, (a.y + b.y) / 2.0};
    double d = distance(a, b);
    double h = sqrt(r * r - (d / 2.0) * (d / 2.0));
    double angle = atan2(b.y - a.y, b.x - a.x) + M_PI / 2.0;
    Point center = {mid.x + h * cos(angle), mid.y + h * sin(angle)};
    return center;
}

int numPoints(int** points, int pointsSize, int* pointsColSize, int r) {
    Point pts[MAX_POINTS];
    for (int i = 0; i < pointsSize; i++) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    int max_count = 1;
    double radius = (double)r;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (distance(pts[i], pts[j]) > 2 * radius) continue;

            Point center = getCircleCenter(pts[i], pts[j], radius);
            int count = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (distance(center, pts[k]) <= radius + 1e-6) {
                    count++;
                }
            }
            if (count > max_count) max_count = count;
        }
    }

    for (int i = 0; i < pointsSize; i++) {
        int count = 0;
        for (int j = 0; j < pointsSize; j++) {
            if (distance(pts[i], pts[j]) <= radius + 1e-6) {
                count++;
            }
        }
        if (count > max_count) max_count = count;
    }

    return max_count;
}