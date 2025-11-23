#include <stdio.h>
#include <stdlib.h>

int* findOriginalArray(int* changed, int changedSize, int* returnSize) {
    if (changedSize % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(changedSize / 2 * sizeof(int));
    *returnSize = 0;

    int* count = (int*)calloc(20001, sizeof(int));
    for (int i = 0; i < changedSize; i++) {
        count[changed[i] + 10000]++;
    }

    for (int i = 0; i <= 10000; i++) {
        int num = i - 10000;
        while (count[num + 10000] > 0) {
            if (count[num * 2 + 10000] == 0) {
                free(result);
                *returnSize = 0;
                free(count);
                return NULL;
            }
            result[*returnSize] = num;
            (*returnSize)++;
            count[num + 10000]--;
            count[num * 2 + 10000]--;
        }
    }

    free(count);
    return result;
}