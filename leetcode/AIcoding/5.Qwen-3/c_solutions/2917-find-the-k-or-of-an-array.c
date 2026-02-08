#include <stdio.h>
#include <stdlib.h>

int kthElement(int* nums, int numsSize, int k) {
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] & (1 << (k - 1))) {
            result++;
        }
    }
    return result;
}

int kOr(int* nums, int numsSize, int k) {
    int result = 0;
    for (int i = 0; i < 32; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] & (1 << i)) {
                count++;
            }
        }
        if (count >= k) {
            result |= (1 << i);
        }
    }
    return result;
}