#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findOriginalArray(int* changed, int changedSize, int* returnSize) {
    if (changedSize % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int n = changedSize / 2;
    int* original = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    int* count = (int*)calloc(100001, sizeof(int));
    for (int i = 0; i < changedSize; i++) {
        count[changed[i]]++;
    }

    for (int i = 0; i <= 100000; i++) {
        if (count[i] > 0) {
            if (i == 0) {
                if (count[i] % 2 != 0) {
                    *returnSize = 0;
                    free(original);
                    free(count);
                    return NULL;
                }
                for (int j = 0; j < count[i] / 2; j++) {
                    original[(*returnSize)++] = 0;
                }
            } else {
                if (count[i] > count[i * 2]) {
                    *returnSize = 0;
                    free(original);
                    free(count);
                    return NULL;
                }
                for (int j = 0; j < count[i]; j++) {
                    original[(*returnSize)++] = i;
                    count[i * 2]--;
                }
            }
        }
    }

    free(count);

    if (*returnSize != n) {
        *returnSize = 0;
        free(original);
        return NULL;
    }

    return original;
}