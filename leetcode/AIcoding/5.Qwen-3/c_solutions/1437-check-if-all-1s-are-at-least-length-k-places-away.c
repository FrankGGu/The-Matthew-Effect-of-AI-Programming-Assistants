#include <stdbool.h>
#include <stdlib.h>

bool kLengthApart(int* nums, int numsSize, int k) {
    int lastOneIndex = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            if (lastOneIndex != -1 && i - lastOneIndex - 1 < k) {
                return false;
            }
            lastOneIndex = i;
        }
    }
    return true;
}