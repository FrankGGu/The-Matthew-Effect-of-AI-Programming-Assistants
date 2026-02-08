#include <stdbool.h>
#include <stdlib.h>
#include <limits.h> // For INT_MAX, INT_MIN

typedef struct {
    int x;
    int y;
} Point;

int comparePoints(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }
    return p1->y - p2->y;
}

bool isRectangleCover(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    if (rectanglesSize == 0) {
        return false;
    }

    long long totalArea = 0;
    int minX = INT_MAX, minY = INT_MAX;
    int maxX = INT_MIN, maxY = INT_MIN;

    Point* points = (Point*)malloc(sizeof(Point) * rectanglesSize * 4);
    if (points == NULL) {
        return false;
    }
    int pointIdx = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int x1 = rectangles[i][0];
        int y1 = rectangles[i][1];
        int x2 = rectangles[i][2];
        int y2 = rectangles[i][3];

        minX = (x1 < minX) ? x1 : minX;
        minY = (y1 < minY) ? y1 : minY;
        maxX = (x2 > maxX) ? x2 : maxX;
        maxY = (y2 > maxY) ? y2 : maxY;

        points[pointIdx++] = (Point){x1, y1};
        points[pointIdx++] = (Point){x1, y2};
        points[pointIdx++] = (Point){x2, y1};
        points[pointIdx++] = (Point){x2, y2};

        totalArea += (long long)(x2 - x1) * (y2 - y1);
    }

    if (totalArea != (long long)(maxX - minX) * (maxY - minY)) {
        free(points);
        return false;
    }

    qsort(points, rectanglesSize * 4, sizeof(Point), comparePoints);

    Point unmatched[4];
    int unmatchedCount = 0;

    for (int i = 0; i < rectanglesSize * 4; i++) {
        if (i + 1 < rectanglesSize * 4 && 
            points[i].x == points[i+1].x && 
            points[i].y == points[i+1].y) {
            i++; 
        } else {
            if (unmatchedCount >= 4) {
                free(points);
                return false;
            }
            unmatched[unmatchedCount++] = points[i];
        }
    }

    if (unmatchedCount != 4) {
        free(points);
        return false;
    }

    qsort(unmatched, 4, sizeof(Point), comparePoints);

    Point expectedCorners[4] = {
        {minX, minY},
        {minX, maxY},
        {maxX, minY},
        {maxX, maxY}
    };
    qsort(expectedCorners, 4, sizeof(Point), comparePoints);

    for (int i = 0; i < 4; i++) {
        if (unmatched[i].x != expectedCorners[i].x || unmatched[i].y != expectedCorners[i].y) {
            free(points);
            return false;
        }
    }

    free(points);
    return true;
}