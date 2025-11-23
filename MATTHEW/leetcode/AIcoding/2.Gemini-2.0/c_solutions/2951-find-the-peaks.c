#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findPeaks(int* mountain, int mountainSize, int* returnSize) {
    if (mountainSize < 3) {
        *returnSize = 0;
        return NULL;
    }

    int* peaks = (int*)malloc(mountainSize * sizeof(int));
    int count = 0;

    for (int i = 1; i < mountainSize - 1; i++) {
        if (mountain[i] > mountain[i - 1] && mountain[i] > mountain[i + 1]) {
            peaks[count++] = i;
        }
    }

    *returnSize = count;
    return peaks;
}