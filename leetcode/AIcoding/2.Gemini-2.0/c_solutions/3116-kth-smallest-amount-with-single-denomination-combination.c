#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kthSmallest(int* nums, int numsSize, int k) {
    int low = 1, high = 100000;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            count += mid / nums[i];
        }
        if (count >= k) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return low;
}