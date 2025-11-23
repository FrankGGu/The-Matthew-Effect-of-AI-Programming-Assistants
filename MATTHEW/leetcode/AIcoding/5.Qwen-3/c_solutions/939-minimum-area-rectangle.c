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

    Point* sortedPoints = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        sortedPoints[i].x = points[i][0];
        sortedPoints[i].y = points[i][1];
    }

    qsort(sortedPoints, pointsSize, sizeof(Point), compare);

    int minArea = INT_MAX;
    int hashSize = 10000;
    int* hash = (int*)calloc(hashSize, sizeof(int));

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (sortedPoints[i].x == sortedPoints[j].x || sortedPoints[i].y == sortedPoints[j].y) continue;

            int key1 = sortedPoints[i].x * 10000 + sortedPoints[i].y;
            int key2 = sortedPoints[j].x * 10000 + sortedPoints[j].y;
            int key3 = sortedPoints[i].x * 10000 + sortedPoints[j].y;
            int key4 = sortedPoints[j].x * 10000 + sortedPoints[i].y;

            if (hash[key1] && hash[key2]) {
                int area = abs((sortedPoints[j].x - sortedPoints[i].x) * (sortedPoints[j].y - sortedPoints[i].y));
                if (area < minArea) minArea = area;
            }

            if (hash[key3] && hash[key4]) {
                int area = abs((sortedPoints[j].x - sortedPoints[i].x) * (sortedPoints[j].y - sortedPoints[i].y));
                if (area < minArea) minArea = area;
            }

            hash[key1] = 1;
            hash[key2] = 1;
        }
    }

    free(sortedPoints);
    free(hash);

    return minArea == INT_MAX ? 0 : minArea;
}