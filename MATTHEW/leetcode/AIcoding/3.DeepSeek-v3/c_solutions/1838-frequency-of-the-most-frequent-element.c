#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(long long*)a - *(long long*)b;
}

int maxFrequency(int* nums, int numsSize, int k) {
    long long* sorted = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(long long), cmp);

    long long left = 0, total = 0, maxFreq = 1;

    for (int right = 0; right < numsSize; right++) {
        total += sorted[right];

        while ((right - left + 1) * sorted[right] - total > k) {
            total -= sorted[left];
            left++;
        }

        if (right - left + 1 > maxFreq) {
            maxFreq = right - left + 1;
        }
    }

    free(sorted);
    return maxFreq;
}