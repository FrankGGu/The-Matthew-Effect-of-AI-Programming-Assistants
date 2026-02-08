#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canPartition(int* nums, int numsSize, int k, int target, int* groups, int start) {
    if (start == numsSize) {
        for (int i = 0; i < k; i++) {
            if (groups[i] != target) {
                return false;
            }
        }
        return true;
    }

    for (int i = 0; i < k; i++) {
        if (groups[i] + nums[start] <= target) {
            groups[i] += nums[start];
            if (canPartition(nums, numsSize, k, target, groups, start + 1)) {
                return true;
            }
            groups[i] -= nums[start];
        }
        if (groups[i] == 0) {
            break;
        }
    }

    return false;
}

int cmpfunc(const void * a, const void * b) {
   return ( *(int*)b - *(int*)a );
}

bool makesquare(int* matchsticks, int matchsticksSize){
    int sum = 0;
    for (int i = 0; i < matchsticksSize; i++) {
        sum += matchsticks[i];
    }

    if (sum % 4 != 0) {
        return false;
    }

    int side = sum / 4;

    qsort(matchsticks, matchsticksSize, sizeof(int), cmpfunc);

    int groups[4] = {0, 0, 0, 0};
    return canPartition(matchsticks, matchsticksSize, 4, side, groups, 0);
}