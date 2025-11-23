#include <stdbool.h>
#include <stdlib.h>

bool canBePartitioned(int* nums, int numsSize) {
    if (numsSize < 2) {
        return false;
    }

    int* left_inc = (int*)malloc(numsSize * sizeof(int));
    if (left_inc == NULL) {
        return false;
    }

    left_inc[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        if (left_inc[i-1] && (nums[i-1] < nums[i])) {
            left_inc[i] = 1;
        } else {
            left_inc[i] = 0;
        }
    }

    int* right_inc = (int*)malloc(numsSize * sizeof(int));
    if (right_inc == NULL) {
        free(left_inc);
        return false;
    }

    right_inc[numsSize-1] = 1;
    for (int i = numsSize - 2; i >= 0; i--) {
        if (right_inc[i+1] && (nums[i] < nums[i+1])) {
            right_inc[i] = 1;
        } else {
            right_inc[i] = 0;
        }
    }

    bool result = false;
    for (int k = 0; k < numsSize - 1; k++) {
        if (left_inc[k] && right_inc[k+1]) {
            result = true;
            break;
        }
    }

    free(left_inc);
    free(right_inc);

    return result;
}