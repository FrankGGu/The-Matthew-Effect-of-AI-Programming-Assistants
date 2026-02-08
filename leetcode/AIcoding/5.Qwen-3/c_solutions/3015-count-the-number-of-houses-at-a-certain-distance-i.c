#include <stdio.h>
#include <stdlib.h>

int* countHousesAtDistanceN(int n, int m, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i];
        if (q % n == 0) {
            result[i] = (q / n) * (m - n + 1);
        } else {
            result[i] = 0;
        }
    }
    *returnSize = queriesSize;
    return result;
}