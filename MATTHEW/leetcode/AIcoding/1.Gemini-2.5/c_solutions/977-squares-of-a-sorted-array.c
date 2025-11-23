#include <stdlib.h> // For malloc and abs

int* sortedSquares(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(sizeof(int) * numsSize);

    int left = 0;
    int right = numsSize - 1;
    int write_ptr = numsSize - 1;

    while (left <= right) {
        int left_val = nums[left];
        int right_val = nums[right];

        if (abs(left_val) > abs(right_val)) {
            result[write_ptr] = left_val * left_val;
            left++;
        } else {
            result[write_ptr] = right_val * right_val;
            right--;
        }
        write_ptr--;
    }

    return result;
}