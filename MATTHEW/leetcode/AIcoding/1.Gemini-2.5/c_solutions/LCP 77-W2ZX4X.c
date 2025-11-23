#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int runeReserve(int* runes, int runesSize) {
    if (runesSize == 0) {
        return 0;
    }

    qsort(runes, runesSize, sizeof(int), compare);

    int max_k = 1;
    int current_k = 1;

    for (int i = 1; i < runesSize; i++) {
        if (runes[i] == runes[i-1] + 1) {
            current_k++;
        } else if (runes[i] > runes[i-1] + 1) {
            current_k = 1;
        }

        if (current_k > max_k) {
            max_k = current_k;
        }
    }

    return max_k;
}