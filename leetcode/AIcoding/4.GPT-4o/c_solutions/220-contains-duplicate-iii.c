#include <stdbool.h>
#include <stdlib.h>

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (numsSize < 2 || k < 1) return false;

    long long bucketSize = (long long)t + 1;
    long long* buckets = (long long*)calloc((numsSize + 1), sizeof(long long));

    for (int i = 0; i < numsSize; ++i) {
        long long bucketIndex = (long long)nums[i] / bucketSize;
        if (nums[i] < 0) bucketIndex--;

        if (buckets[bucketIndex] != 0) return true;
        if (bucketIndex > 0 && buckets[bucketIndex - 1] != 0 && llabs(buckets[bucketIndex - 1] - nums[i]) <= t) return true;
        if (buckets[bucketIndex + 1] != 0 && llabs(buckets[bucketIndex + 1] - nums[i]) <= t) return true;

        buckets[bucketIndex] = nums[i];
        if (i >= k) {
            long long oldIndex = (long long)nums[i - k] / bucketSize;
            if (nums[i - k] < 0) oldIndex--;
            buckets[oldIndex] = 0;
        }
    }

    free(buckets);
    return false;
}