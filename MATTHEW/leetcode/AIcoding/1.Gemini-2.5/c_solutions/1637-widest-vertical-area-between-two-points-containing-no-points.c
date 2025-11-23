#include <stdlib.h> // For malloc, qsort, free

int compareIntegers(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int maxWidthOfVerticalArea(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 2) {
        return 0;
    }

    // Extract x-coordinates
    int* x_coordinates = (int*)malloc(pointsSize * sizeof(int));
    if (x_coordinates == NULL) {
        // Handle allocation error, though LeetCode environments usually guarantee success for typical constraints
        return 0; 
    }

    for (int i = 0; i < pointsSize; i++) {
        x_coordinates[i] = points[i][0];
    }

    // Sort the x-coordinates
    qsort(x_coordinates, pointsSize, sizeof(int), compareIntegers);

    // Find the maximum difference
    int max_width = 0;
    for (int i = 0; i < pointsSize - 1; i++) {
        int current_width = x_coordinates[i+1] - x_coordinates[i];
        if (current_width > max_width) {
            max_width = current_width;
        }
    }

    // Free the allocated memory
    free(x_coordinates);

    return max_width;
}