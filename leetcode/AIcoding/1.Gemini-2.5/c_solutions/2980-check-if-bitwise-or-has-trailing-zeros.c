#include <stdbool.h>

bool hasTrailingZeros(int* nums, int numsSize) {
    int evenCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            evenCount++;
        }
    }
    return evenCount >= 2;
}