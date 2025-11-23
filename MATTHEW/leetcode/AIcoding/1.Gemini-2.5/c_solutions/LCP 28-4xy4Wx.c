#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int purchasePlans(int* nums, int numsSize, int target) {
    qsort(nums, numsSize, sizeof(int), compare);

    long long count = 0;
    int left = 0;
    int right = numsSize - 1;
    long long MOD = 1000000007;

    while (left < right) {
        if ((long long)nums[left] + nums[right] <= target) {
            count = (count + (right - left)) % MOD;
            left++;
        } else {
            right--;
        }
    }

    return (int)count;
}