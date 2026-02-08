#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int reductionOperations(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    if (numsSize <= 1) {
        return 0;
    }

    int operations = 0;
    int currentDistinctCount = 0;

    // Iterate from the second element to count how many "levels" of reduction each element needs.
    // The smallest element (nums[0]) needs 0 reductions.
    // Each time we encounter a new distinct larger value, it means we need to perform an operation
    // to reduce all values of the previous largest level.
    // The number of operations for a value nums[i] is the number of distinct values strictly smaller than it.
    // This can be simplified.
    // Consider [1,1,2,2,3]. Sorted.
    // nums[0]=1. No operations for this.
    // nums[1]=1. Same as nums[0]. No new level.
    // nums[2]=2. Different from nums[1]. This '2' needs to be reduced to '1'.
    //            This is the first distinct value after '1'. So it needs 1 operation level.
    // nums[3]=2. Same as nums[2].
    // nums[4]=3. Different from nums[3]. This '3' needs to be reduced to '2', then to '1'.
    //            This is the second distinct value after '1'. So it needs 2 operation levels.
    // Total operations = 0 (for 1s) + 1 (for 2s) + 2 (for 3s) = 3.
    // This is not what the problem asks.

    // Let's re-evaluate based on the problem statement:
    // "Reduce all occurrences of the largest value to this next largest value."
    // This means if we have distinct values v1 < v2 < ... < vk.
    // 1. Reduce all vk to v(k-1). (1 operation)
    // 2. Reduce all v(k-1) to v(k-2). (1 operation)
    // ...
    // k-1. Reduce all v2 to v1. (1 operation)
    // Total operations = k-1, where k is the number of distinct values.

    // Let's use the simpler approach of counting distinct elements and subtracting 1.
    // This was my initial thought and it matched all examples.
    // The number of operations is equal to the number of distinct elements minus one.
    // Example: [1,1,2,2,3] -> distinct: 1,2,3 (3 distinct). Operations = 3-1 = 2.
    // My previous trace:
    // 1. Largest 3, next 2. Reduce all 3s to 2s. [1,1,2,2,2]. Ops = 1.
    // 2. Largest 2, next 1. Reduce all 2s to 1s. [1,1,1,1,1]. Ops = 1.
    // Total = 2. This matches.

    // So the task is to count distinct elements.
    int distinctCount = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i-1]) {
            distinctCount++;
        }
    }
    return distinctCount - 1;
}