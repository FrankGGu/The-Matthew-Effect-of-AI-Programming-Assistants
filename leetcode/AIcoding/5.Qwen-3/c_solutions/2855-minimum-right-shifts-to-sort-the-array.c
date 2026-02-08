#include <stdio.h>
#include <stdlib.h>

int minRightShifts(int* nums, int numsSize) {
    int n = numsSize;
    int pos = 0;
    for (int i = 1; i < n; i++) {
        if (nums[i] < nums[i - 1]) {
            pos = i;
            break;
        }
    }
    for (int i = pos; i < n - 1; i++) {
        if (nums[i + 1] < nums[i]) {
            return -1;
        }
    }
    if (pos == 0) {
        return 0;
    }
    return (n - pos) % n;
}