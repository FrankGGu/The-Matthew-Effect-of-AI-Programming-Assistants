#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** groupThePeople(int* groupSizes, int groupSizesSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * groupSizesSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * groupSizesSize);
    *returnSize = 0;

    int* groups[groupSizesSize + 1];
    int groupSizesCount[groupSizesSize + 1];
    for (int i = 0; i <= groupSizesSize; i++) {
        groups[i] = NULL;
        groupSizesCount[i] = 0;
    }

    for (int i = 0; i < groupSizesSize; i++) {
        int size = groupSizes[i];
        if (groups[size] == NULL) {
            groups[size] = (int*)malloc(sizeof(int) * size);
            groupSizesCount[size] = 0;
        }

        groups[size][groupSizesCount[size]] = i;
        groupSizesCount[size]++;

        if (groupSizesCount[size] == size) {
            result[*returnSize] = (int*)malloc(sizeof(int) * size);
            (*returnColumnSizes)[*returnSize] = size;
            for (int j = 0; j < size; j++) {
                result[*returnSize][j] = groups[size][j];
            }
            (*returnSize)++;
            free(groups[size]);
            groups[size] = NULL;
            groupSizesCount[size] = 0;
        }
    }

    return result;
}