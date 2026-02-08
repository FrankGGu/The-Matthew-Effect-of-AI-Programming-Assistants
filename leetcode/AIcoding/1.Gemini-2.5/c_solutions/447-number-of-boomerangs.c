#include <stdlib.h> // For qsort

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int numberOfBoomerangs(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 3) {
        return 0;
    }

    int totalBoomerangs = 0;
    int* distances = (int*)malloc(pointsSize * sizeof(int));
    if (distances == NULL) {
        // Handle allocation failure if necessary, though LeetCode usually guarantees success
        return 0;
    }

    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsSize; j++) {
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            distances[j] = dx * dx + dy * dy;
        }

        qsort(distances, pointsSize, sizeof(int), compareInt);

        int count = 1;
        for (int k = 1; k < pointsSize; k++) {
            if (distances[k] == distances[k-1]) {
                count++;
            } else {
                if (count >= 2) {
                    totalBoomerangs += count * (count - 1);
                }
                count = 1;
            }
        }
        if (count >= 2) {
            totalBoomerangs += count * (count - 1);
        }
    }

    free(distances);
    return totalBoomerangs;
}