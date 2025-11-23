#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize) {
    int* counts = (int*)calloc(200001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        counts[nums[i]]++;
    }

    int operations = 0;
    for (int i = 0; i < 200001; i++) {
        if (counts[i] == 1) {
            free(counts);
            return -1;
        } else if (counts[i] > 0) {
            operations += (counts[i] + 2) / 3;
        }
    }

    free(counts);
    return operations;
}