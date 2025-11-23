#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

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
    int i = 0;
    while (i < pointsSize - 1) {
        int j = i + 1;
        while (j < pointsSize && pts[j].x == pts[i].x) {
            j++;
        }
        if (j - i >= 2) {
            int min_y = INT_MAX;
            for (int k = i; k < j; k++) {
                if (pts[k].y < min_y) min_y = pts[k].y;
            }
            int max_y = INT_MIN;
            for (int k = i; k < j; k++) {
                if (pts[k].y > max_y) max_y = pts[k].y;
            }
            int width = pts[j - 1].x - pts[i].x;
            int height = max_y - min_y;
            max_area = (width * height > max_area) ? width * height : max_area;
        }
        i = j;
    }

    free(pts);
    return max_area;
}