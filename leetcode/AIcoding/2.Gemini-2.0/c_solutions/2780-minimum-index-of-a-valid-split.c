#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumIndex(int* nums, int numsSize) {
    int total_count = 0;
    for (int i = 0; i < numsSize; i++) {
        total_count++;
    }

    for (int i = 0; i < numsSize - 1; i++) {
        int left_count = 0;
        int num = nums[i];
        for (int j = 0; j <= i; j++) {
            if (nums[j] == num) {
                left_count++;
            }
        }

        int right_count = 0;
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] == num) {
                right_count++;
            }
        }

        if (left_count * 2 > (i + 1) && right_count * 2 > (numsSize - i - 1)) {
            return i;
        }
    }

    return -1;
}