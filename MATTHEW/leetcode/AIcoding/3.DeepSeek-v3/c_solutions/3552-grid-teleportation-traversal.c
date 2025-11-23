#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int cmp(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }
    return p1->y - p2->y;
}

int canTravel(int** points, int pointsSize, int* pointsColSize) {
    Point* sorted = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        sorted[i].x = points[i][0];
        sorted[i].y = points[i][1];
    }

    qsort(sorted, pointsSize, sizeof(Point), cmp);

    for (int i = 0; i < pointsSize - 1; i++) {
        if (sorted[i].x == sorted[i + 1].x && sorted[i].y + 1 == sorted[i + 1].y) {
            continue;
        }
        int found = 0;
        for (int j = i + 1; j < pointsSize; j++) {
            if (sorted[j].x > sorted[i].x) {
                break;
            }
            if (sorted[j].y == sorted[i].y) {
                found = 1;
                break;
            }
        }
        if (!found) {
            free(sorted);
            return 0;
        }
    }

    free(sorted);
    return 1;
}