#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* concertBand(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* positions = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        positions[i] = i + 1;
    }
    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];
        int idxA = -1, idxB = -1;
        for (int j = 0; j < n; j++) {
            if (positions[j] == a) idxA = j;
            if (positions[j] == b) idxB = j;
        }
        if (idxA != -1 && idxB != -1) {
            int temp = positions[idxA];
            positions[idxA] = positions[idxB];
            positions[idxB] = temp;
        }
    }
    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int idx = -1;
        for (int j = 0; j < n; j++) {
            if (positions[j] == a) {
                idx = j;
                break;
            }
        }
        result[i] = idx + 1;
    }
    *returnSize = queriesSize;
    free(positions);
    return result;
}