#include <stdlib.h>
#include <stdio.h> // For NULL, though not strictly needed for the solution logic

long long cross_product(int* p1, int* p2, int* p3) {
    return (long long)(p2[0] - p1[0]) * (p3[1] - p1[1]) - (long long)(p2[1] - p1[1]) * (p3[0] - p1[0]);
}

int comparePoints(const void* a, const void* b) {
    int* p1 = *(int**)a;
    int* p2 = *(int**)b;
    if (p1[0] != p2[0]) {
        return p1[0] - p2[0];
    }
    return p1[1] - p2[1];
}

int** outerTrees(int** points, int pointsSize, int* pointsColSize, int* returnSize, int** returnColumnSizes) {
    // Handle edge cases: 0, 1, or 2 points. All are on the fence.
    if (pointsSize <= 2) {
        *returnSize = pointsSize;
        *returnColumnSizes = (int*)malloc(sizeof(int) * pointsSize);
        if (*returnColumnSizes == NULL) return NULL;

        int** result = (int**)malloc(sizeof(int*) * pointsSize);
        if (result == NULL) {
            free(*returnColumnSizes);
            return NULL;
        }

        for (int i = 0; i < pointsSize; i++) {
            (*returnColumnSizes)[i] = 2;
            result[i] = (int*)malloc(sizeof(int) * 2);
            if (result[i] == NULL) {
                // Clean up previously allocated memory
                for (int j = 0; j < i; j++) free(result[j]);
                free(result);
                free(*returnColumnSizes);
                return NULL;
            }
            result[i][0] = points[i][0];
            result[i][1] = points[i][1];
        }
        return result;
    }

    // Sort points lexicographically
    qsort(points, pointsSize, sizeof(int*), comparePoints);

    // hull will store pointers to the points in the original array
    int** hull = (int**)malloc(sizeof(int*) * pointsSize);
    if (hull == NULL) return NULL;
    int hullSize = 0;

    // Build lower hull
    for (int i = 0; i < pointsSize; i++) {
        // While the last two points in hull and the current point make a non-left turn (right turn or collinear),
        // pop the second to last point. This ensures a counter-clockwise path.
        while (hullSize >= 2 && cross_product(hull[hullSize - 2], hull[hullSize - 1], points[i]) < 0) {
            hullSize--;
        }
        hull[hullSize++] = points[i];
    }

    // Build upper hull
    // Start from the second to last point and go down to the first.
    // The `hullSize > lowerHullSize` condition ensures we only pop points added by the upper hull construction
    // and don't remove points that are part of the lower hull and should remain.
    int lowerHullSize = hullSize;
    for (int i = pointsSize - 2; i >= 0; i--) {
        while (hullSize > lowerHullSize && cross_product(hull[hullSize - 2], hull[hullSize - 1], points[i]) < 0) {
            hullSize--;
        }
        hull[hullSize++] = points[i];
    }

    // The first and last points of the sorted array are added twice (once for lower, once for upper hull).
    // Other points might also be duplicated if they are part of both lower and upper hull segments.
    // Sort the hull to group duplicates and then remove them.
    qsort(hull, hullSize, sizeof(int*), comparePoints);

    int newHullSize = 0;
    for (int i = 0; i < hullSize; i++) {
        // If it's the first point or different from the previous point, add it to the unique hull.
        if (i == 0 || comparePoints(&hull[i - 1], &hull[i]) != 0) {
            hull[newHullSize++] = hull[i];
        }
    }
    hullSize = newHullSize;

    // Prepare the return array
    *returnSize = hullSize;
    *returnColumnSizes = (int*)malloc(sizeof(int) * hullSize);
    if (*returnColumnSizes == NULL) {
        free(hull);
        return NULL;
    }

    int** result = (int**)malloc(sizeof(int*) * hullSize);
    if (result == NULL) {
        free(hull);
        free(*returnColumnSizes);
        return NULL;
    }

    for (int i = 0; i < hullSize; i++) {
        (*returnColumnSizes)[i] = 2;
        result[i] = (int*)malloc(sizeof(int) * 2);
        if (result[i] == NULL) {
            // Clean up previously allocated memory
            for (int j = 0; j < i; j++) free(result[j]);
            free(result);
            free(hull);
            free(*returnColumnSizes);
            return NULL;
        }
        result[i][0] = hull[i][0];
        result[i][1] = hull[i][1];
    }

    free(hull); // Free the temporary hull array
    return result;
}