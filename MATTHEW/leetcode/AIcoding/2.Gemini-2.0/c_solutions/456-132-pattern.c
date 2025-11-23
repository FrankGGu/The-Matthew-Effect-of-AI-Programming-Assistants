#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool find132pattern(int* nums, int numsSize){
    if (numsSize < 3) return false;

    int min_i[numsSize];
    min_i[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        min_i[i] = (nums[i] < min_i[i - 1]) ? nums[i] : min_i[i - 1];
    }

    for (int j = numsSize - 1, top = -1; j >= 0; j--) {
        int stack[numsSize];
        if (nums[j] > min_i[j]) {
            while (top >= 0 && stack[top] <= min_i[j]) {
                top--;
            }
            if (top >= 0 && stack[top] < nums[j]) {
                return true;
            }
            stack[++top] = nums[j];
        }
    }

    return false;
}