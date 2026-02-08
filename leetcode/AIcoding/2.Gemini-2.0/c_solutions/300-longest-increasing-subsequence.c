#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int* tails = (int*)malloc(sizeof(int) * numsSize);
    int size = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int left = 0;
        int right = size;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (tails[mid] < num) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        tails[left] = num;
        if (left == size) {
            size++;
        }
    }

    free(tails);
    return size;
}