#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int cmpfunc(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    int n = pointsSize;
    qsort(points, n, sizeof(Point), cmpfunc);

    int min_area = INT_MAX;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            if (dx == 0 || dy == 0) continue;
            int area = abs(dx * dy);
            if (area >= min_area) continue;

            int found = 0;
            for (int k = 0; k < n; k++) {
                if (k == i || k == j) continue;
                int dx2 = points[k][0] - points[i][0];
                int dy2 = points[k][1] - points[i][1];
                if (dx2 == dx && dy2 == dy) {
                    found = 1;
                    break;
                }
                if (dx2 == -dx && dy2 == -dy) {
                    found = 1;
                    break;
                }
            }
            if (found) {
                min_area = area;
            }
        }
    }

    return min_area == INT_MAX ? 0 : min_area;
}