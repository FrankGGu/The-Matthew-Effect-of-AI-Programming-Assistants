#include <stdio.h>
#include <stdlib.h>

int* findLatestGroup(int* groupSizes, int groupSizesSize, int m, int* returnSize) {
    int* result = NULL;
    *returnSize = 0;
    int max = 0;

    int count[100001] = {0};

    for (int i = 0; i < groupSizesSize; i++) {
        count[groupSizes[i]]++;
    }

    for (int i = 0; i <= 100000; i++) {
        if (count[i] == m) {
            max = i;
        }
    }

    if (max > 0) {
        result = (int*)malloc(count[max] * sizeof(int));
        int index = 0;
        for (int i = 0; i < groupSizesSize; i++) {
            if (groupSizes[i] == max) {
                result[index++] = i + 1;
            }
        }
        *returnSize = index;
    }

    return result;
}