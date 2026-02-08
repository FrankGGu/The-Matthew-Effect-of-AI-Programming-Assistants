#include <stdio.h>
#include <stdlib.h>

int minMaxGame(int* nums, int numsSize) {
    while (numsSize > 1) {
        int* new_nums = (int*)malloc((numsSize / 2) * sizeof(int));
        for (int i = 0; i < numsSize / 2; i++) {
            if (i % 2 == 0) {
                new_nums[i] = fmin(nums[2 * i], nums[2 * i + 1]);
            } else {
                new_nums[i] = fmax(nums[2 * i], nums[2 * i + 1]);
            }
        }
        free(nums);
        nums = new_nums;
        numsSize /= 2;
    }
    return nums[0];
}