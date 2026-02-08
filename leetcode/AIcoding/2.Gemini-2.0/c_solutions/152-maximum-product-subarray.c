#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProduct(int* nums, int numsSize) {
    int max_so_far = nums[0];
    int min_so_far = nums[0];
    int result = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int curr = nums[i];
        int temp_max = max_so_far;
        max_so_far = fmax(curr, fmax(max_so_far * curr, min_so_far * curr));
        min_so_far = fmin(curr, fmin(temp_max * curr, min_so_far * curr));

        result = fmax(result, max_so_far);
    }

    return result;
}