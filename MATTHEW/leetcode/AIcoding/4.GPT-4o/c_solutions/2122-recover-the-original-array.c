#include <stdio.h>
#include <stdlib.h>

int* recoverArray(int* changed, int changedSize, int* returnSize) {
    int* original = (int*)malloc((changedSize / 2) * sizeof(int));
    int* count = (int*)calloc(100001, sizeof(int));
    int originalSize = 0;
    int i, x;

    for (i = 0; i < changedSize; i++) {
        count[changed[i]]++;
    }

    for (x = 0; x <= 100000; x++) {
        if (count[x] > 0) {
            while (count[x] > 0 && count[x * 2] > 0) {
                original[originalSize++] = x;
                count[x]--;
                count[x * 2]--;
            }
        }
    }

    if (originalSize * 2 != changedSize) {
        free(original);
        original = NULL;
    }

    *returnSize = originalSize;
    free(count);
    return original;
}