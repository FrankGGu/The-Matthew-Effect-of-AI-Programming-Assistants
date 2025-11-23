#include <limits.h>

int maxSubArray(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0; // Or handle as per problem constraints, usually numsSize >= 1
    }

    int currentMax = nums[0];
    int globalMax = nums[0];

    for (int i = 1; i < numsSize; i++) {
        currentMax = (nums[i] > currentMax + nums[i]) ? nums[i] : (currentMax + nums[i]);
        globalMax = (globalMax > currentMax) ? globalMax : currentMax;
    }

    return globalMax;
}