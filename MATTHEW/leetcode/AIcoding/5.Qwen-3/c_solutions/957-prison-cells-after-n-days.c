#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* prisonAfterNDays(int* cells, int cellsSize, int N, int* returnSize) {
    int* result = (int*)malloc(cellsSize * sizeof(int));
    int* next = (int*)malloc(cellsSize * sizeof(int));
    int* seen[1440];
    int seenIndex = 0;
    int day = 0;

    while (day < N) {
        for (int i = 1; i < cellsSize - 1; i++) {
            next[i] = (cells[i - 1] == cells[i + 1]) ? 1 : 0;
        }
        for (int i = 0; i < cellsSize; i++) {
            next[i] = (i == 0 || i == cellsSize - 1) ? 0 : next[i];
        }

        int* key = (int*)malloc(cellsSize * sizeof(int));
        memcpy(key, next, cellsSize * sizeof(int));

        int found = 0;
        for (int i = 0; i < seenIndex; i++) {
            if (memcmp(seen[i], key, cellsSize * sizeof(int)) == 0) {
                day = N - (N - day) % (seenIndex - i);
                found = 1;
                break;
            }
        }

        if (!found) {
            seen[seenIndex++] = key;
        } else {
            free(key);
        }

        memcpy(cells, next, cellsSize * sizeof(int));
        day++;
    }

    memcpy(result, cells, cellsSize * sizeof(int));
    *returnSize = cellsSize;
    free(next);
    return result;
}