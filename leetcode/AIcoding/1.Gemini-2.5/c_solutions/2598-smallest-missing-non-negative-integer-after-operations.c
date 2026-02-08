#include <stdlib.h>

int smallestMissingNonNegativeInteger(int* nums, int numsSize, int modulo) {
    int* counts = (int*)calloc(modulo, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        counts[nums[i] % modulo]++;
    }

    for (int k = 0; k < modulo; k++) {
        if (counts[k] == 0) {
            free(counts);
            return k;
        }
    }

    free(counts);
    return modulo;
}