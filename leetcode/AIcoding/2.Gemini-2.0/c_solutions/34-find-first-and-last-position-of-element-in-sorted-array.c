#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* searchRange(int* nums, int numsSize, int target, int* returnSize){
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;
    *returnSize = 2;

    if (numsSize == 0) {
        return result;
    }

    int low = 0, high = numsSize - 1;
    int first = -1, last = -1;

    // Find first occurrence
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (nums[mid] == target) {
            first = mid;
            high = mid - 1;
        } else if (nums[mid] < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    // Find last occurrence
    low = 0;
    high = numsSize - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (nums[mid] == target) {
            last = mid;
            low = mid + 1;
        } else if (nums[mid] < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    result[0] = first;
    result[1] = last;

    return result;
}