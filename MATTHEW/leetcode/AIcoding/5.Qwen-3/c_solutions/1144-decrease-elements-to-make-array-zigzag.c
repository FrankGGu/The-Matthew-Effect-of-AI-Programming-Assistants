#include <stdio.h>
#include <stdlib.h>

int move(int* nums, int numsSize, int isLeft) {
    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        if (isLeft) {
            if (nums[i] > nums[i + 1]) {
                count += nums[i] - nums[i + 1];
                nums[i] = nums[i + 1];
            }
        } else {
            if (nums[i] < nums[i + 1]) {
                count += nums[i + 1] - nums[i];
                nums[i + 1] = nums[i];
            }
        }
    }
    return count;
}

int movesToMakeZigzag(int* nums, int numsSize) {
    if (numsSize <= 1) return 0;
    int* copy1 = (int*)malloc(numsSize * sizeof(int));
    int* copy2 = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        copy1[i] = nums[i];
        copy2[i] = nums[i];
    }
    int res1 = move(copy1, numsSize, 1);
    int res2 = move(copy2, numsSize, 0);
    return res1 < res2 ? res1 : res2;
}