#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* markElements(int n, int** queries, int queriesSize, int* queriesColSize, int threshold, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = 0;
    }

    for (int i = 0; i < queriesSize; i++) {
        int type = queries[i][0];
        int index = queries[i][1];
        int val = queries[i][2];

        if (type == 0) {
            if (val > threshold) {
                result[index] = 1;
            }
        } else {
            if (val > threshold) {
                result[index] = -1;
            }
        }
    }

    *returnSize = n;
    return result;
}