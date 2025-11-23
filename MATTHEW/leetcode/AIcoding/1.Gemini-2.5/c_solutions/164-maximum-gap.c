#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MAX, INT_MIN

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maximumGap(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0;
    }

    // Find the minimum and maximum values in the array
    int minVal = INT_MAX;
    int maxVal = INT_MIN;
    for (int i = 0; i < numsSize; i++) {
        minVal = min(minVal, nums[i]);
        maxVal = max(maxVal, nums[i]);
    }

    // If all elements are the same, the maximum gap is 0
    if (minVal == maxVal) {
        return 0;
    }

    // Calculate the bucket size.
    // The minimum possible gap is (maxVal - minVal) / (numsSize - 1).
    // We choose a bucket size that is at least this average gap.
    // This ensures that the maximum gap will always be found between buckets,
    // not within a single bucket.
    int bucketSize = (maxVal - minVal) / (numsSize - 1);
    if (bucketSize == 0) { // Ensure bucketSize is at least 1
        bucketSize = 1;
    }

    // Calculate the number of buckets needed
    // (maxVal - minVal) / bucketSize gives the number of bucket intervals.
    // Add 1 to get the total number of buckets.
    int numBuckets = (maxVal - minVal) / bucketSize + 1;

    // Allocate memory for min/max values in each bucket and a flag to check if bucket is used
    int* minBucket = (int*)malloc(sizeof(int) * numBuckets);
    int* maxBucket = (int*)malloc(sizeof(int) * numBuckets);
    int* bucketUsed = (int*)malloc(sizeof(int) * numBuckets); // 0 for false, 1 for true

    // Initialize buckets
    for (int i = 0; i < numBuckets; i++) {
        minBucket[i] = INT_MAX;
        maxBucket[i] = INT_MIN;
        bucketUsed[i] = 0; // Mark as unused
    }

    // Distribute numbers into buckets
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        // Calculate the bucket index for the current number
        int bucketIdx = (num - minVal) / bucketSize;

        // Update min and max values for this bucket
        minBucket[bucketIdx] = min(minBucket[bucketIdx], num);
        maxBucket[bucketIdx] = max(maxBucket[bucketIdx], num);
        bucketUsed[bucketIdx] = 1; // Mark bucket as used
    }

    // Iterate through buckets to find the maximum gap
    int maxGap = 0;
    int prevMax = minVal; // The maximum value of the previous non-empty bucket

    for (int i = 0; i < numBuckets; i++) {
        if (bucketUsed[i]) {
            // The gap is between the minimum of the current bucket and the maximum of the previous non-empty bucket
            maxGap = max(maxGap, minBucket[i] - prevMax);
            // Update prevMax to the maximum of the current bucket
            prevMax = maxBucket[i];
        }
    }

    // Free allocated memory
    free(minBucket);
    free(maxBucket);
    free(bucketUsed);

    return maxGap;
}