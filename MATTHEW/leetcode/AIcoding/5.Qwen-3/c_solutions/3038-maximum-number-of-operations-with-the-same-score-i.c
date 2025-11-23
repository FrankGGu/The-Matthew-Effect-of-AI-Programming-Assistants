#include <stdio.h>
#include <stdlib.h>

int maxOperations(int* nums, int numsSize) {
    int count = 0;
    int i = 0;
    while (i + 1 < numsSize) {
        int sum = nums[i] + nums[i + 1];
        int j = i + 2;
        while (j + 1 < numsSize && nums[j] + nums[j + 1] == sum) {
            j += 2;
        }
        if (j - i >= 2) {
            count++;
            i = j;
        } else {
            break;
        }
    }
    return count;
}