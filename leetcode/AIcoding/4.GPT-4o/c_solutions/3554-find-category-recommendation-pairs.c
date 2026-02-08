#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 1000

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int** findCategoryRecommendations(char ***items, int itemsSize, int* itemsColSize, int* returnSize, int** returnColumnSizes) {
    int **result = (int **)malloc(MAX * sizeof(int *));
    *returnColumnSizes = (int *)malloc(MAX * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < itemsSize; i++) {
        for (int j = 0; j < itemsColSize[i]; j++) {
            for (int k = j + 1; k < itemsColSize[i]; k++) {
                if (strcmp(items[i][j], items[i][k]) != 0) {
                    int *pair = (int *)malloc(2 * sizeof(int));
                    pair[0] = j;
                    pair[1] = k;
                    result[*returnSize] = pair;
                    (*returnColumnSizes)[*returnSize] = 2;
                    (*returnSize)++;
                }
            }
        }
    }

    qsort(result, *returnSize, sizeof(int *), cmp);
    return result;
}