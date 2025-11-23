#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int k) {
    int* count = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int operations = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] % k != 0) {
            operations += (k - (count[i] % k));
        }
    }

    free(count);
    return operations;
}