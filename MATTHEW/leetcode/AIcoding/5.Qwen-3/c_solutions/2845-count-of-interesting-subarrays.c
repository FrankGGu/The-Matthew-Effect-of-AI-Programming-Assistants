#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countInterestingSubarrays(int* nums, int numsSize, int k) {
    int count[10] = {0};
    int result = 0;
    int current = 0;
    count[0] = 1;
    for (int i = 0; i < numsSize; i++) {
        current = (current + (nums[i] % 2 == 1 ? 1 : 0)) % 10;
        result += count[(current - k + 10) % 10];
        count[current]++;
    }
    return result;
}