#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maximumSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    long long mod = 1000000007;
    long long res = 0;
    long long comb = 1;

    for (int i = 0; i < k; i++) {
        res = (res + comb * nums[numsSize - 1 - i]) % mod;
        comb = comb * (numsSize - 1 - i) / (i + 1);
    }

    return (int)res;
}

int minimumSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    long long mod = 1000000007;
    long long res = 0;
    long long comb = 1;

    for (int i = 0; i < k; i++) {
        res = (res + comb * nums[i]) % mod;
        comb = comb * (numsSize - 1 - i) / (i + 1);
    }

    return (int)res;
}

int* resultsArray(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = 2;
    int* res = (int*)malloc(2 * sizeof(int));
    res[0] = maximumSum(nums, numsSize, k);
    res[1] = minimumSum(nums, numsSize, k);
    return res;
}