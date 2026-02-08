#include <stdio.h>
#include <stdlib.h>

int* blockPlacementQueries(int* blocks, int blocksSize, int** queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        int count = 0;
        for (int j = left; j <= right; j++) {
            count += blocks[j];
        }
        result[i] = count;
    }

    return result;
}