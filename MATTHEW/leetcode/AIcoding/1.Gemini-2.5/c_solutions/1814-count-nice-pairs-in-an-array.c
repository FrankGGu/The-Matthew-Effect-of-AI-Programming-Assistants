#include <stdlib.h>

int rev(int n) {
    int reversed_n = 0;
    while (n > 0) {
        reversed_n = reversed_n * 10 + (n % 10);
        n /= 10;
    }
    return reversed_n;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int countNicePairs(int* nums, int numsSize) {
    long long count = 0;
    long long MOD = 1000000007;

    int* diffs = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        diffs[i] = nums[i] - rev(nums[i]);
    }

    qsort(diffs, numsSize, sizeof(int), compare);

    for (int i = 0; i < numsSize; ) {
        int current_diff = diffs[i];
        long long freq = 0;
        int j = i;
        while (j < numsSize && diffs[j] == current_diff) {
            freq++;
            j++;
        }
        count = (count + (freq * (freq - 1) / 2)) % MOD;
        i = j;
    }

    free(diffs);

    return (int)count;
}