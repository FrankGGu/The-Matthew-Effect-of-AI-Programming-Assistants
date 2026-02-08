#include <stdio.h>
#include <stdlib.h>

long long countPairs(int* nums, int numsSize, int k) {
    int* modCount = (int*)calloc(k, sizeof(int));
    long long result = 0;

    for (int i = 0; i < numsSize; i++) {
        int mod = nums[i] % k;
        int complement = (k - mod) % k;
        result += modCount[complement];
        modCount[mod]++;
    }

    free(modCount);
    return result;
}