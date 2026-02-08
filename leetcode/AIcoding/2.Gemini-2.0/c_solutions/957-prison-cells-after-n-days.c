#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* prisonAfterNDays(int* cells, int cellsSize, int N, int* returnSize){
    int *seen[256] = {NULL};
    int *current = cells;
    int period = 0;
    int found = 0;

    while (N > 0) {
        if (seen[hash(current, cellsSize)] != NULL) {
            found = 1;
            break;
        }

        seen[hash(current, cellsSize)] = current;

        int *next = (int*)malloc(sizeof(int) * cellsSize);
        next[0] = 0;
        next[cellsSize - 1] = 0;

        for (int i = 1; i < cellsSize - 1; i++) {
            next[i] = (current[i - 1] == current[i + 1]) ? 1 : 0;
        }

        current = next;
        N--;
        period++;
    }

    if (found) {
        N %= period;
        current = cells;
        while (N > 0) {
            int *next = (int*)malloc(sizeof(int) * cellsSize);
            next[0] = 0;
            next[cellsSize - 1] = 0;

            for (int i = 1; i < cellsSize - 1; i++) {
                next[i] = (current[i - 1] == current[i + 1]) ? 1 : 0;
            }

            current = next;
            N--;
        }
    }

    *returnSize = cellsSize;
    return current;
}

int hash(int *cells, int size) {
    int hashVal = 0;
    for (int i = 0; i < size; i++) {
        hashVal = hashVal * 31 + cells[i];
    }
    return abs(hashVal % 256);
}