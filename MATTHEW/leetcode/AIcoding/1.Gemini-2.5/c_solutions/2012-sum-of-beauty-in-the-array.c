#include <stdlib.h>

int sumOfBeauties(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    int* max_left = (int*)malloc(numsSize * sizeof(int));
    int* min_right = (int*)malloc(numsSize * sizeof(int));

    int current_max_so_far = nums[0];
    for (int i = 1; i < numsSize; ++i) {
        max_left[i] = current_max_so_far;
        if (nums[i] > current_max_so_far) {
            current_max_so_far = nums[i];
        }
    }

    int current_min_so_far = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; --i) {
        min_right[i] = current_min_so_far;
        if (nums[i] < current_min_so_far) {
            current_min_so_far = nums[i];
        }
    }

    int total_beauty = 0;
    for (int i = 1; i < numsSize - 1; ++i) {
        if (nums[i] > max_left[i] && nums[i] < min_right[i]) {
            total_beauty += 2;
        } else if (nums[i] > nums[i - 1] && nums[i] < nums[i + 1]) {
            total_beauty += 1;
        }
    }

    free(max_left);
    free(min_right);

    return total_beauty;
}