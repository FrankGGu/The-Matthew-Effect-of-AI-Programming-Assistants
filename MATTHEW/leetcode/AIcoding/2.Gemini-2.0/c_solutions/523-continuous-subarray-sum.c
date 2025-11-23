#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize < 2) {
        return false;
    }

    if (k == 0) {
        for (int i = 0; i < numsSize - 1; i++) {
            if (nums[i] == 0 && nums[i + 1] == 0) {
                return true;
            }
        }
        return false;
    }

    int *rem = (int*)malloc((k) * sizeof(int));
    for(int i = 0; i < k; i++) rem[i] = -2;

    rem[0] = -1;
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum = (sum + nums[i]) % k;
        if(rem[sum] != -2) {
            if(i - rem[sum] > 1) {
                free(rem);
                return true;
            }
        } else {
            rem[sum] = i;
        }
    }
    free(rem);
    return false;
}