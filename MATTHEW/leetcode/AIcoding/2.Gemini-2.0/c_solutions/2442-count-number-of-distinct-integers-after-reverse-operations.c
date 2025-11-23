#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int reverse(int num) {
    int reversed = 0;
    while (num > 0) {
        reversed = reversed * 10 + num % 10;
        num /= 10;
    }
    return reversed;
}

int distinctIntegers(int* nums, int numsSize) {
    int* distinct = (int*)malloc(sizeof(int) * (2 * numsSize));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        int original = nums[i];
        int reversed = reverse(nums[i]);

        int originalFound = 0;
        for (int j = 0; j < count; j++) {
            if (distinct[j] == original) {
                originalFound = 1;
                break;
            }
        }
        if (!originalFound) {
            distinct[count++] = original;
        }

        int reversedFound = 0;
        for (int j = 0; j < count; j++) {
            if (distinct[j] == reversed) {
                reversedFound = 1;
                break;
            }
        }
        if (!reversedFound) {
            distinct[count++] = reversed;
        }
    }

    free(distinct);
    return count;
}