#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minImpossibleOR(int* nums, int numsSize) {
    int seen[32] = {0};
    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] & (nums[i] - 1)) == 0) {
            int count = 0;
            while(nums[i] > 0){
                nums[i] >>= 1;
                count++;
            }
            seen[count-1] = 1;
        }
    }

    for (int i = 0; i < 32; i++) {
        if (seen[i] == 0) {
            return 1 << i;
        }
    }

    return -1;
}