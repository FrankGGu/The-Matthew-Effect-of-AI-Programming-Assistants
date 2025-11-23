#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool kLengthApart(int* nums, int numsSize, int k) {
    int last_one = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            if (last_one != -1 && i - last_one - 1 < k) {
                return false;
            }
            last_one = i;
        }
    }
    return true;
}