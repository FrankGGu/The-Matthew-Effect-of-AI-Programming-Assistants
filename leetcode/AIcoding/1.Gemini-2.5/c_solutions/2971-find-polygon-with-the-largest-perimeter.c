#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long largestPerimeter(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    long long currentSum = 0;
    long long maxPerimeter = -1;

    for (int i = 0; i < numsSize; ++i) {
        if (i >= 2) {
            if (currentSum > nums[i]) {
                maxPerimeter = currentSum + nums[i];
            }
        }
        currentSum += nums[i];
    }

    return maxPerimeter;
}