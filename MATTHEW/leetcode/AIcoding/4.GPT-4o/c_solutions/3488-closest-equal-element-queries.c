#include <stdio.h>
#include <stdlib.h>

int* closestEqualQueries(int* arr, int arrSize, int* queries, int queriesSize, int* returnSize) {
    int* res = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int idx = queries[i];
        int found = -1;

        for (int j = idx; j >= 0; j--) {
            if (arr[j] == arr[idx]) {
                found = j;
                break;
            }
        }

        res[i] = found;
    }

    return res;
}