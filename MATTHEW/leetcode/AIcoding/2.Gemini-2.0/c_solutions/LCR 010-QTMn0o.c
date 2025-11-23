#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int subarraySum(int* nums, int numsSize, int k) {
    int count = 0;
    int sum = 0;
    int* map = (int*)malloc(sizeof(int) * (2 * numsSize + 1));
    for (int i = 0; i < 2 * numsSize + 1; i++) {
        map[i] = 0;
    }
    map[numsSize] = 1; 

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum - k + numsSize >= 0 && sum - k + numsSize < 2 * numsSize + 1) {
            count += map[sum - k + numsSize];
        }
        map[sum + numsSize]++;
    }

    free(map);
    return count;
}