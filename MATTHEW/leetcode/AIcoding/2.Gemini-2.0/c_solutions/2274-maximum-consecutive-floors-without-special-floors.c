#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxConsecutive(int bottom, int top, int* special, int specialSize) {
    qsort(special, specialSize, sizeof(int), compare);
    int max_diff = 0;
    if (special[0] - bottom > max_diff) {
        max_diff = special[0] - bottom;
    }
    for (int i = 1; i < specialSize; i++) {
        if (special[i] - special[i - 1] - 1 > max_diff) {
            max_diff = special[i] - special[i - 1] - 1;
        }
    }
    if (top - special[specialSize - 1] > max_diff) {
        max_diff = top - special[specialSize - 1];
    }
    return max_diff;
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}