#include <stdio.h>
#include <stdlib.h>

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

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 4) return 0;
    qsort(points, pointsSize, sizeof(Point), compare);

    int minArea = INT_MAX;
    int n = pointsSize;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (points[i][0] == points[j][0] || points[i][1] == points[j][1]) continue;
            int x1 = points[i][0], y1 = points[i][1];
            int x2 = points[j][0], y2 = points[j][1];
            int found = 0;
            for (int k = 0; k < n; k++) {
                if (k == i || k == j) continue;
                if (points[k][0] == x1 && points[k][1] == y2) {
                    found = 1;
                    break;
                }
                if (points[k][0] == x2 && points[k][1] == y1) {
                    found = 1;
                    break;
                }
            }
            if (found) {
                int area = abs((x1 - x2) * (y1 - y2));
                if (area < minArea) minArea = area;
            }
        }
    }
    return minArea == INT_MAX ? 0 : minArea;
}