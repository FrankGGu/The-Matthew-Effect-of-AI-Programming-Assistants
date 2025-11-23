#include <stdlib.h>

long long calculate_f(int x, int a, int b, int c) {
    return (long long)a * x * x + (long long)b * x + c;
}

int* sortTransformedArray(int* nums, int numsSize, int a, int b, int c, int* returnSize) {
    *returnSize = numsSize;
    if (numsSize == 0) {
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * numsSize);
    if (result == NULL) {
        return NULL;
    }

    int left = 0;
    int right = numsSize - 1;

    if (a >= 0) {
        int idx = numsSize - 1;
        while (left <= right) {
            long long val_left = calculate_f(nums[left], a, b, c);
            long long val_right = calculate_f(nums[right], a, b, c);

            if (val_left > val_right) {
                result[idx--] = (int)val_left;
                left++;
            } else {
                result[idx--] = (int)val_right;
                right--;
            }
        }
    } else { // a < 0
        int idx = 0;
        while (left <= right) {
            long long val_left = calculate_f(nums[left], a, b, c);
            long long val_right = calculate_f(nums[right], a, b, c);

            if (val_left < val_right) {
                result[idx++] = (int)val_left;
                left++;
            } else {
                result[idx++] = (int)val_right;
                right--;
            }
        }
    }

    return result;
}