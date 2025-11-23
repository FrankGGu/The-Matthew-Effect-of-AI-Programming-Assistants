#include <stdio.h>
#include <stdlib.h>

int findGCD(int* nums, int numsSize) {
    int min = nums[0];
    int max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }

    int a = min;
    int b = max;
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}