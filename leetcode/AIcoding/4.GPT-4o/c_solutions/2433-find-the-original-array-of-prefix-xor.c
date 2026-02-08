#include <stdlib.h>

int* findArray(int* pref, int prefSize, int* returnSize) {
    int* original = (int*)malloc(prefSize * sizeof(int));
    original[0] = pref[0];
    for (int i = 1; i < prefSize; i++) {
        original[i] = pref[i] ^ pref[i - 1];
    }
    *returnSize = prefSize;
    return original;
}