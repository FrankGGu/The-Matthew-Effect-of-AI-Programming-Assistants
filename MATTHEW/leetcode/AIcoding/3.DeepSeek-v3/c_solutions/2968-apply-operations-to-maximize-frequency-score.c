#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    long long aa = *(long long*)a;
    long long bb = *(long long*)b;
    if (aa > bb) return 1;
    if (aa < bb) return -1;
    return 0;
}

long long maxFrequencyScore(int* nums, int numsSize, long long k) {
    long long *arr = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        arr[i] = nums[i];
    }
    qsort(arr, numsSize, sizeof(long long), cmp);

    long long *prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + arr[i];
    }

    long long left = 0;
    long long maxFreq = 1;

    for (long long right = 0; right < numsSize; right++) {
        while ((arr[right] * (right - left + 1) - (prefix[right + 1] - prefix[left])) > k) {
            left++;
        }
        maxFreq = (right - left + 1) > maxFreq ? (right - left + 1) : maxFreq;
    }

    free(arr);
    free(prefix);
    return maxFreq;
}