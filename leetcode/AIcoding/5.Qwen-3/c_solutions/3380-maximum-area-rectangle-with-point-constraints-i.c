#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int compare(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int maxArea(int** points, int pointsSize, int* pointsColSize) {
    Point* pts = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }
    qsort(pts, pointsSize, sizeof(Point), compare);

    int max_area = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (pts[i].x == pts[j].x || pts[i].y == pts[j].y) continue;
            int x1 = pts[i].x, y1 = pts[i].y;
            int x2 = pts[j].x, y2 = pts[j].y;
            int x3 = x1, y3 = y2;
            int x4 = x2, y4 = y1;
            int found1 = 0, found2 = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (pts[k].x == x3 && pts[k].y == y3) found1 = 1;
                if (pts[k].x == x4 && pts[k].y == y4) found2 = 1;
            }
            if (found1 && found2) {
                int area = abs(x1 - x2) * abs(y1 - y2);
                if (area > max_area) max_area = area;
            }
        }
    }
    free(pts);
    return max_area;
}