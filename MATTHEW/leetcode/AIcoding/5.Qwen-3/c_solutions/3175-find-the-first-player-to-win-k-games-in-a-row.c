#include <stdio.h>
#include <stdlib.h>

int kEmptySlots(int* nums, int numsSize, int k) {
    int* positions = (int*)malloc((numsSize + 2) * sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        positions[nums[i]] = i;
    }

    int result = -1;
    int left = 1;
    int right = k + 2;

    while (right <= numsSize) {
        if (positions[left] < positions[right]) {
            result = right;
        } else if (positions[right] < positions[left]) {
            result = left;
        }
        left++;
        right++;
    }

    free(positions);
    return result;
}