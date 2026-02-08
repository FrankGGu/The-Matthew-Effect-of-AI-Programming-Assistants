#include <stdio.h>
#include <stdlib.h>

int** groupThePeople(int* groupSizes, int groupSizesSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(groupSizesSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(groupSizesSize * sizeof(int));
    *returnSize = 0;

    int** groups = (int**)calloc(groupSizesSize + 1, sizeof(int*));
    int* counts = (int*)calloc(groupSizesSize + 1, sizeof(int));

    for (int i = 0; i < groupSizesSize; i++) {
        int size = groupSizes[i];
        if (counts[size] == 0) {
            groups[size] = (int*)malloc(size * sizeof(int));
        }
        groups[size][counts[size]++] = i;

        if (counts[size] == size) {
            result[*returnSize] = groups[size];
            (*returnColumnSizes)[*returnSize] = size;
            (*returnSize)++;
            counts[size] = 0;
        }
    }

    free(counts);
    return result;
}