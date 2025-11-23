#include <stdbool.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool isGood(int* base, int baseSize) {
    if (baseSize < 2) {
        return false;
    }

    qsort(base, baseSize, sizeof(int), compare);

    for (int i = 0; i < baseSize - 1; i++) {
        if (base[i] != i + 1) {
            return false;
        }
    }

    if (base[baseSize - 1] != baseSize - 1) {
        return false;
    }

    return true;
}