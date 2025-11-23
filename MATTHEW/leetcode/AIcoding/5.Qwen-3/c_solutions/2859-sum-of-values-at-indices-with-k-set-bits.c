#include <stdio.h>
#include <stdlib.h>

int sumIndicesWithKBits(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        int count = 0;
        int num = i;
        while (num) {
            count += num & 1;
            num >>= 1;
        }
        if (count == k) {
            sum += nums[i];
        }
    }
    return sum;
}