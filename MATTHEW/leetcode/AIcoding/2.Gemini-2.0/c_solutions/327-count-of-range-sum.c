#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int merge_sort_and_count(long long *sums, int low, int high, int lower, int upper) {
    if (low >= high) {
        return 0;
    }

    int mid = low + (high - low) / 2;
    int count = merge_sort_and_count(sums, low, mid, lower, upper) + merge_sort_and_count(sums, mid + 1, high, lower, upper);

    int i = low, j = mid + 1, k = mid + 1, l = mid + 1;
    long long cache[high - low + 1];
    int cache_index = 0;

    for (; i <= mid; ++i) {
        while (k <= high && sums[k] - sums[i] < lower) {
            k++;
        }
        while (l <= high && sums[l] - sums[i] <= upper) {
            l++;
        }
        count += l - k;

        while (j <= high && sums[j] < sums[i]) {
            cache[cache_index++] = sums[j++];
        }
        cache[cache_index++] = sums[i];
    }

    while (j <= high) {
        cache[cache_index++] = sums[j++];
    }

    for (int m = 0; m < cache_index; ++m) {
        sums[low + m] = cache[m];
    }

    return count;
}

int countRangeSum(int* nums, int numsSize, int lower, int upper) {
    long long *sums = (long long *)malloc(sizeof(long long) * (numsSize + 1));
    sums[0] = 0;
    for (int i = 0; i < numsSize; ++i) {
        sums[i + 1] = sums[i] + nums[i];
    }

    int count = merge_sort_and_count(sums, 0, numsSize, lower, upper);
    free(sums);
    return count;
}