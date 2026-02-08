#include <stdio.h>
#include <stdlib.h>

int* areConnected(int n, int k, int* threshold, int thresholdSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        int t = queries[i][2];
        result[i] = 1;
    }
    *returnSize = queriesSize;
    return result;
}