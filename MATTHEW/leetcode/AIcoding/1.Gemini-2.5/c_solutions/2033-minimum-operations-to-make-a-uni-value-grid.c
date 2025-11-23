#include <stdlib.h> // For malloc, qsort, abs

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int** grid, int gridSize, int* gridColSize, int x) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int totalElements = rows * cols;

    int* flatArray = (int*)malloc(totalElements * sizeof(int));
    if (flatArray == NULL) {
        return -1; 
    }

    int k = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            flatArray[k++] = grid[i][j];
        }
    }

    int firstRemainder = flatArray[0] % x;
    for (int i = 1; i < totalElements; i++) {
        if (flatArray[i] % x != firstRemainder) {
            free(flatArray);
            return -1;
        }
    }

    qsort(flatArray, totalElements, sizeof(int), compare);

    int median = flatArray[totalElements / 2];

    long long operations = 0;
    for (int i = 0; i < totalElements; i++) {
        operations += abs(flatArray[i] - median) / x;
    }

    free(flatArray);
    return (int)operations;
}