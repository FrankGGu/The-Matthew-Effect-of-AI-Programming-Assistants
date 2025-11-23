#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int findUnsortedSubarray(int* nums, int numsSize) {
    int n = numsSize;
    int minVal = 2147483647; // INT_MAX
    int maxVal = -2147483648; // INT_MIN

    bool flag = false;
    for (int i = 1; i < n; i++) {
        if (nums[i] < nums[i-1]) {
            flag = true;
        }
        if (flag) {
            if (nums[i] < minVal) {
                minVal = nums[i];
            }
        }
    }

    flag = false;
    for (int i = n - 2; i >= 0; i--) {
        if (nums[i] > nums[i+1]) {
            flag = true;
        }
        if (flag) {
            if (nums[i] > maxVal) {
                maxVal = nums[i];
            }
        }
    }

    int l = 0;
    for (l = 0; l < n; l++) {
        if (minVal < nums[l]) {
            break;
        }
    }

    int r = n - 1;
    for (r = n - 1; r >= 0; r--) {
        if (maxVal > nums[r]) {
            break;
        }
    }

    if (r - l < 0) {
        return 0;
    } else {
        return r - l + 1;
    }
}