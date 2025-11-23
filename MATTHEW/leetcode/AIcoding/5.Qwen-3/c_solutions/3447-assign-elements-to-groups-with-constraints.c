#include <stdio.h>
#include <stdlib.h>

int* groupThePeople(int* groupSizes, int groupSizesSize, int* returnSize) {
    int** groups = (int**)malloc((groupSizesSize + 1) * sizeof(int*));
    int* count = (int*)malloc((groupSizesSize + 1) * sizeof(int));
    int* result = NULL;
    int resultSize = 0;

    for (int i = 0; i < groupSizesSize; i++) {
        int size = groupSizes[i];
        if (!groups[size]) {
            groups[size] = (int*)malloc(groupSizesSize * sizeof(int));
            count[size] = 0;
        }
        groups[size][count[size]++] = i;
    }

    for (int i = 1; i <= groupSizesSize; i++) {
        if (groups[i]) {
            int numGroups = count[i] / i;
            for (int j = 0; j < numGroups; j++) {
                int* group = (int*)malloc(i * sizeof(int));
                for (int k = 0; k < i; k++) {
                    group[k] = groups[i][j * i + k];
                }
                resultSize += i + 1;
                result = (int*)realloc(result, resultSize * sizeof(int));
                result[resultSize - i - 1] = i;
                for (int k = 0; k < i; k++) {
                    result[resultSize - i - 1 + k + 1] = group[k];
                }
                free(group);
            }
            free(groups[i]);
        }
    }

    *returnSize = resultSize;
    return result;
}