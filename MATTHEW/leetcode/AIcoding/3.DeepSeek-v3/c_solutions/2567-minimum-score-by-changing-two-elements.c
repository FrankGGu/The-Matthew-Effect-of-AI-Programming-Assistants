#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minimizeSum(int* nums, int numsSize) {
    if (numsSize == 3) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int option1 = nums[numsSize - 1] - nums[2];
    int option2 = nums[numsSize - 3] - nums[0];
    int option3 = nums[numsSize - 2] - nums[1];

    int min1 = (option1 < option2) ? option1 : option2;
    return (min1 < option3) ? min1 : option3;
}