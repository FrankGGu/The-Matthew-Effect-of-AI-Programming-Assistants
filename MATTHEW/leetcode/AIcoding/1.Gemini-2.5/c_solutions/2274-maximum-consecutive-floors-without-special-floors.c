#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxConsecutive(int bottom, int top, int* special, int specialSize) {
    qsort(special, specialSize, sizeof(int), compare);

    int max_consecutive = 0;

    max_consecutive = special[0] - bottom;

    for (int i = 1; i < specialSize; i++) {
        int current_gap = special[i] - special[i-1] - 1;
        if (current_gap > max_consecutive) {
            max_consecutive = current_gap;
        }
    }

    int last_gap = top - special[specialSize - 1];
    if (last_gap > max_consecutive) {
        max_consecutive = last_gap;
    }

    return max_consecutive;
}