#include <stdio.h>
#include <stdlib.h>

int countFairPairs(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int left = 0;
        int right = numsSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sorted[mid] < nums[i]) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        count += left;
    }

    free(sorted);
    return count;
}