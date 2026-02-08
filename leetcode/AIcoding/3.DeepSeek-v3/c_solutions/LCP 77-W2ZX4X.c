#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int runeReserve(int* runes, int runesSize) {
    if (runesSize <= 1) return runesSize;

    qsort(runes, runesSize, sizeof(int), cmp);

    int maxLen = 1;
    int currentLen = 1;

    for (int i = 1; i < runesSize; i++) {
        if (runes[i] - runes[i-1] <= 1) {
            currentLen++;
        } else {
            if (currentLen > maxLen) {
                maxLen = currentLen;
            }
            currentLen = 1;
        }
    }

    if (currentLen > maxLen) {
        maxLen = currentLen;
    }

    return maxLen;
}