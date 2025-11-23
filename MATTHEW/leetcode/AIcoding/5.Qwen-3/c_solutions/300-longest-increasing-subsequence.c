#include <stdio.h>
#include <stdlib.h>

int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int* tails = (int*)malloc(numsSize * sizeof(int));
    int length = 1;

    tails[0] = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int left = 0, right = length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (tails[mid] < nums[i]) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        tails[left] = nums[i];
        if (left == length) {
            length++;
        }
    }

    free(tails);
    return length;
}