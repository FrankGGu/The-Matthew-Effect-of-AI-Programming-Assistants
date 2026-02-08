#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(long long*)a - *(long long*)b);
}

long long minimalKSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    long long sum = 0;
    long long prev = 0;

    for (int i = 0; i < numsSize && k > 0; i++) {
        long long curr = nums[i];
        long long start = prev + 1;
        long long end = curr - 1;

        if (start <= end) {
            long long count = end - start + 1;
            if (count > k) {
                count = k;
                end = start + count - 1;
            }
            sum += (start + end) * count / 2;
            k -= count;
        }
        prev = curr;
    }

    if (k > 0) {
        long long start = prev + 1;
        long long end = start + k - 1;
        sum += (start + end) * k / 2;
    }

    return sum;
}