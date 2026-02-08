#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxOperations(int* nums, int numsSize){
    if (numsSize < 2) return 0;
    int target = nums[0] + nums[1];
    int count = 1;
    for (int i = 2; i < numsSize; i += 2) {
        if (i + 1 < numsSize && nums[i] + nums[i + 1] == target) {
            count++;
        } else {
            break;
        }
    }
    return count;
}