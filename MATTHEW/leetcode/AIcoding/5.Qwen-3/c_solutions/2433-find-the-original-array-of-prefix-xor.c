#include <stdio.h>
#include <stdlib.h>

int* findOriginalArray(int* pref, int prefSize, int* returnSize) {
    *returnSize = 0;
    if (prefSize == 0) return NULL;

    int* result = (int*)malloc(prefSize * sizeof(int));
    if (!result) return NULL;

    result[0] = pref[0];
    *returnSize = 1;

    for (int i = 1; i < prefSize; i++) {
        result[i] = pref[i] ^ pref[i-1];
        (*returnSize)++;
    }

    return result;
}