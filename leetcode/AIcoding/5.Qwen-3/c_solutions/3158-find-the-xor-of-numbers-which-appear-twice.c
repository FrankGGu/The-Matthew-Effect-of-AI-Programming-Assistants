#include <stdio.h>
#include <stdlib.h>

int duplicateNumbersXOR(int* nums, int numsSize) {
    int count[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    int result = 0;
    for (int i = 0; i <= 100; i++) {
        if (count[i] == 2) {
            result ^= i;
        }
    }
    return result;
}