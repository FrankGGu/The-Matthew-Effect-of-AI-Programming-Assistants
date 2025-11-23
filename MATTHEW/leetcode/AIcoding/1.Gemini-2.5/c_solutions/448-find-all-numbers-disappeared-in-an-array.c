#include <stdlib.h> // For malloc, abs

int* findDisappearedNumbers(int* nums, int numsSize, int* returnSize) {
    for (int i = 0; i < numsSize; i++) {
        int val = abs(nums[i]);
        int index = val - 1;

        if (nums[index] > 0) {
            nums[index] = -nums[index];
        }
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            result[count++] = i + 1;
        }
    }

    *returnSize = count;
    return result;
}