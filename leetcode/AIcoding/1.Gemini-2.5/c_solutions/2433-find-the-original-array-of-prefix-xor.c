#include <stdlib.h>

int* findArray(int* pref, int prefSize, int* returnSize) {
    int* arr = (int*)malloc(prefSize * sizeof(int));
    if (arr == NULL) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = prefSize;

    if (prefSize == 0) {
        return arr;
    }

    arr[0] = pref[0];
    for (int i = 1; i < prefSize; i++) {
        arr[i] = pref[i] ^ pref[i - 1];
    }

    return arr;
}