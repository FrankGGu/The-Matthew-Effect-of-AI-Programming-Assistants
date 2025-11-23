#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int specialArray(int* nums, int numsSize) {
    int left = 0;
    int right = numsSize;
    int result = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] >= mid) {
                count++;
            }
        }

        if (count == mid) {
            result = mid;
            break;
        } else if (count > mid) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}