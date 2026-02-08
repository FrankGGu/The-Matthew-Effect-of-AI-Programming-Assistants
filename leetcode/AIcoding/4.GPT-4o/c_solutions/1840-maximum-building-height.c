#include <stdio.h>
#include <stdlib.h>

struct Point {
    int position;
    int height;
};

int cmp(const void *a, const void *b) {
    return ((struct Point *)a)->position - ((struct Point *)b)->position;
}

int maxBuilding(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize) {
    struct Point *points = malloc((restrictionsSize + 2) * sizeof(struct Point));
    for (int i = 0; i < restrictionsSize; i++) {
        points[i].position = restrictions[i][0];
        points[i].height = restrictions[i][1];
    }
    points[restrictionsSize].position = 1;
    points[restrictionsSize].height = 0;
    points[restrictionsSize + 1].position = n;
    points[restrictionsSize + 1].height = 0;

    restrictionsSize += 2;
    qsort(points, restrictionsSize, sizeof(struct Point), cmp);

    for (int i = 1; i < restrictionsSize; i++) {
        int dist = points[i].position - points[i - 1].position;
        points[i].height = fmax(points[i].height, points[i - 1].height + dist);
    }

    for (int i = restrictionsSize - 2; i >= 0; i--) {
        int dist = points[i + 1].position - points[i].position;
        points[i].height = fmax(points[i].height, points[i + 1].height - dist);
    }

    int maxHeight = 0;
    for (int i = 0; i < restrictionsSize - 1; i++) {
        int dist = points[i + 1].position - points[i].position;
        int h1 = points[i].height;
        int h2 = points[i + 1].height;
        maxHeight = fmax(maxHeight, (h1 + h2 + dist) / 2 + (h1 + h2 + dist) % 2);
    }

    free(points);
    return maxHeight;
}