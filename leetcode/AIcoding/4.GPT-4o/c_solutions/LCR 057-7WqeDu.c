#include <stdbool.h>
#include <stdlib.h>

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (k <= 0 || numsSize <= 1) return false;

    long long bucketSize = (long long)t + 1;
    long long* buckets = (long long*)calloc((numsSize + 1), sizeof(long long));
    int index;

    for (int i = 0; i < numsSize; i++) {
        if (i > k) {
            index = (nums[i - k - 1] < 0) ? (nums[i - k - 1] + 1) / bucketSize - 1 : nums[i - k - 1] / bucketSize;
            buckets[index] = 0;
        }

        index = (nums[i] < 0) ? (nums[i] + 1) / bucketSize - 1 : nums[i] / bucketSize;

        if (buckets[index] != 0) return true;
        if (index > 0 && buckets[index - 1] != 0 && labs(nums[i] - buckets[index - 1]) <= t) return true;
        if (buckets[index + 1] != 0 && labs(nums[i] - buckets[index + 1]) <= t) return true;

        buckets[index] = nums[i];
    }

    free(buckets);
    return false;
}