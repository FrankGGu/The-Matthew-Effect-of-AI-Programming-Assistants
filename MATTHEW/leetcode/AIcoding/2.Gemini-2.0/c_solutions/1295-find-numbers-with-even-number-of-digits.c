#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findNumbers(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int digits = 0;
        while (num > 0) {
            num /= 10;
            digits++;
        }
        if (digits % 2 == 0) {
            count++;
        }
    }
    return count;
}