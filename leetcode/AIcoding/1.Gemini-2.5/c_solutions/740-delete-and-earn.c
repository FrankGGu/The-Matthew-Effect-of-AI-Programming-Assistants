#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int deleteAndEarn(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* points = (int*)calloc(max_val + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        points[nums[i]] += nums[i];
    }

    int prev2 = 0;
    int prev1 = points[1];

    for (int i = 2; i <= max_val; i++) {
        int current = max(prev1, points[i] + prev2);
        prev2 = prev1;
        prev1 = current;
    }

    int result = prev1;

    free(points);

    return result;
}