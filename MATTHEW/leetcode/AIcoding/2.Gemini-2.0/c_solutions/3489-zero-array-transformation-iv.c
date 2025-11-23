#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize) {
    int operations = 0;
    int start = 0;

    while (start < numsSize) {
        while (start < numsSize && nums[start] == 0) {
            start++;
        }

        if (start < numsSize) {
            operations++;
            int end = start;
            while (end < numsSize && nums[end] != 0) {
                nums[end] = 0;
                end++;
            }
            start = end;
        }
    }

    return operations;
}