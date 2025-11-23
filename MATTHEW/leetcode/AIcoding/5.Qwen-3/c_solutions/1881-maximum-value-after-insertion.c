#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *x = *(char**)a;
    char *y = *(char**)b;
    return strcmp(x, y);
}

int maximumValue(char ** grid, int gridSize, int* gridColSize) {
    int maxVal = 0;
    char **temp = (char**)malloc(gridSize * sizeof(char*));
    for (int i = 0; i < gridSize; i++) {
        temp[i] = (char*)malloc((strlen(grid[i]) + 1) * sizeof(char));
        strcpy(temp[i], grid[i]);
    }
    qsort(temp, gridSize, sizeof(char*), compare);
    for (int i = 0; i < gridSize; i++) {
        int len = strlen(temp[i]);
        if (len > maxVal) {
            maxVal = len;
        }
    }
    free(temp);
    return maxVal;
}