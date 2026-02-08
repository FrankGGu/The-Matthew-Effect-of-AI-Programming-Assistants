#include <stdio.h>
#include <stdlib.h>

int** groupThePeople(int* groupSizes, int groupSizesSize, int** returnColumnSizes, int* returnSize) {
    int maxSize = 0;
    for (int i = 0; i < groupSizesSize; i++) {
        if (groupSizes[i] > maxSize) {
            maxSize = groupSizes[i];
        }
    }

    int** groups = (int**)malloc(groupSizesSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(groupSizesSize * sizeof(int));
    int* count = (int*)calloc(maxSize + 1, sizeof(int));
    int** result = (int**)malloc(groupSizesSize * sizeof(int*));
    int resultSize = 0;

    for (int i = 0; i < groupSizesSize; i++) {
        count[groupSizes[i]]++;
    }

    for (int i = 1; i <= maxSize; i++) {
        if (count[i] > 0) {
            groups[i] = (int*)malloc(count[i] * sizeof(int));
            count[i] = 0;  // Reset count for storing indices
        }
    }

    for (int i = 0; i < groupSizesSize; i++) {
        int size = groupSizes[i];
        groups[size][count[size]] = i;
        count[size]++;

        if (count[size] == size) {
            result[resultSize] = (int*)malloc(size * sizeof(int));
            for (int j = 0; j < size; j++) {
                result[resultSize][j] = groups[size][j];
            }
            resultSize++;
            count[size] = 0;  // Reset for next group
        }
    }

    free(count);
    *returnColumnSizes = (int*)malloc(resultSize * sizeof(int));
    for (int i = 0; i < resultSize; i++) {
        (*returnColumnSizes)[i] = groupSizes[result[i][0]];
    }
    *returnSize = resultSize;

    free(groups);
    return result;
}