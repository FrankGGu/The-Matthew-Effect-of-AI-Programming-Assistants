#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool check(int* nums, int numsSize){
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > nums[(i + 1) % numsSize]) {
            count++;
        }
    }
    return count <= 1;
}