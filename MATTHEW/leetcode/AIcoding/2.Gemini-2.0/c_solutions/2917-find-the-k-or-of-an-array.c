#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findKOr(int* nums, int numsSize, int k){
    int result = 0;
    for (int i = 0; i < 32; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((nums[j] >> i) & 1) {
                count++;
            }
        }
        if (count >= k) {
            result |= (1 << i);
        }
    }
    return result;
}