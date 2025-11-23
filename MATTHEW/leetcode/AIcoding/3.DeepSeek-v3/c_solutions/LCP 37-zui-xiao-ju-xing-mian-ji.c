#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

int cmp_x(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    Point* pts = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    qsort(pts, pointsSize, sizeof(Point), cmp_x);

    int min_area = INT_MAX;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            Point p1 = pts[i];
            Point p2 = pts[j];

            if (p1.x == p2.x || p1.y == p2.y) continue;

            int found1 = 0, found2 = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (pts[k].x == p1.x && pts[k].y == p2.y) found1 = 1;
                if (pts[k].x == p2.x && pts[k].y == p1.y) found2 = 1;
                if (found1 && found2) break;
            }

            if (found1 && found2) {
                int area = abs(p2.x - p1.x) * abs(p2.y - p1.y);
                if (area < min_area) min_area = area;
            }
        }
    }

    free(pts);
    return min_area == INT_MAX ? 0 : min_area;
}