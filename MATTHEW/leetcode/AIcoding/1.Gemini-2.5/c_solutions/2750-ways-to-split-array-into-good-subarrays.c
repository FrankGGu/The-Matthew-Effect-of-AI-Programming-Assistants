#include <stddef.h> // For size_t
#include <stdlib.h> // For malloc, free

#define MOD 1000000007

int waysToSplitArray(int* nums, int numsSize) {
    int* one_indices = (int*)malloc(numsSize * sizeof(int));
    int one_count = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == 1) {
            one_indices[one_count++] = i;
        }
    }

    if (one_count == 0) {
        free(one_indices);
        return 0;
    }

    long long ways = 1;

    for (int i = 0; i < one_count - 1; ++i) {
        long long diff = (long long)one_indices[i+1] - one_indices[i];
        ways = (ways * diff) % MOD;
    }

    free(one_indices);
    return (int)ways;
}