#include <stdio.h>
#include <stdlib.h>

int* recoverOriginal(int* changed, int changedSize, int* returnSize) {
    int* result = (int*)malloc(changedSize / 2 * sizeof(int));
    *returnSize = 0;

    if (changedSize % 2 != 0) {
        return NULL;
    }

    int* freq = (int*)calloc(changedSize + 1, sizeof(int));
    for (int i = 0; i < changedSize; i++) {
        freq[changed[i]]++;
    }

    for (int i = 0; i < changedSize; i++) {
        if (freq[changed[i]] == 0) continue;
        if (changed[i] * 2 > changedSize) {
            return NULL;
        }
        if (freq[changed[i] * 2] == 0) {
            return NULL;
        }
        result[*returnSize++] = changed[i];
        freq[changed[i]]--;
        freq[changed[i] * 2]--;
    }

    return result;
}