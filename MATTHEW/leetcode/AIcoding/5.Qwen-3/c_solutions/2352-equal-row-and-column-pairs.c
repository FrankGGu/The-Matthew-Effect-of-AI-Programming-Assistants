#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** rows;
    int size;
} RowMap;

int compare(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

int getHash(char** row, int n) {
    int hash = 0;
    for (int i = 0; i < n; i++) {
        hash ^= (int)row[i][0];
    }
    return hash;
}

int equalPairs(char*** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    char** sortedRows = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        sortedRows[i] = (char*)malloc(n * sizeof(char));
        memcpy(sortedRows[i], grid[i], n * sizeof(char));
        qsort(sortedRows[i], n, sizeof(char), compare);
    }

    int* colHashes = (int*)malloc(n * sizeof(int));
    for (int j = 0; j < n; j++) {
        char* col = (char*)malloc(n * sizeof(char));
        for (int i = 0; i < n; i++) {
            col[i] = grid[i][j];
        }
        qsort(col, n, sizeof(char), compare);
        colHashes[j] = getHash(col, n);
        free(col);
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (getHash(sortedRows[i], n) == colHashes[j]) {
                count++;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(sortedRows[i]);
    }
    free(sortedRows);
    free(colHashes);

    return count;
}