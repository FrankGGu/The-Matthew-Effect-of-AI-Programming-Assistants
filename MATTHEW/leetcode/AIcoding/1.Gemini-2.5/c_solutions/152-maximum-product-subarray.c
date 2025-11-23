#include <limits.h>
#include <stdlib.h>
#include <stdio.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxProduct(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int max_so_far = nums[0];
    int min_so_far = nums[0];
    int result = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int curr = nums[i];
        int temp_max = max(curr, max(max_so_far * curr, min_so_far * curr));
        min_so_far = min(curr, min(max_so_far * curr, min_so_far * curr));

        max_so_far = temp_max;

        result = max(result, max_so_far);
    }

    return result;
}