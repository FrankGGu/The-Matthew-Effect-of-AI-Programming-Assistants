#include <stdio.h>
#include <stdlib.h>

int minElement(int* nums, int numsSize) {
    int min = nums[0];
    for (int i = 0; i < numsSize; i++) {
        int sum = 0;
        int num = nums[i];
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        if (sum < min) {
            min = sum;
        }
    }
    return min;
}