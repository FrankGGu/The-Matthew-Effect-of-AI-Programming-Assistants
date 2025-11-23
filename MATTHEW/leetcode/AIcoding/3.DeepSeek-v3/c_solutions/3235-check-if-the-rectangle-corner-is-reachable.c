#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int x;
    int y;
} Point;

int cmp(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

bool canReachCorner(int xCorner, int yCorner, int** circles, int circlesSize, int* circlesColSize) {
    Point* points = (Point*)malloc(circlesSize * sizeof(Point));
    int idx = 0;

    for (int i = 0; i < circlesSize; i++) {
        int x = circles[i][0];
        int y = circles[i][1];
        int r = circles[i][2];

        if (x - r <= 0 && y + r >= yCorner) return false;
        if (x + r >= xCorner && y - r <= 0) return false;

        if (x - r <= 0 || y + r >= yCorner) {
            points[idx].x = x - r;
            points[idx].y = y + r;
            idx++;
        }
        if (x + r >= xCorner || y - r <= 0) {
            points[idx].x = x + r;
            points[idx].y = y - r;
            idx++;
        }
    }

    if (idx == 0) return true;

    qsort(points, idx, sizeof(Point), cmp);

    int maxY = -1;
    for (int i = 0; i < idx; i++) {
        if (points[i].y > maxY) {
            maxY = points[i].y;
        }
        if (points[i].x <= 0 && maxY >= yCorner) {
            free(points);
            return false;
        }
    }

    free(points);
    return true;
}