#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int k) {
    int count = 0;
    int operations = 0;
    int seen[51] = {0};
    for (int i = numsSize - 1; i >= 0; i--) {
        operations++;
        if (nums[i] <= k && seen[nums[i]] == 0) {
            seen[nums[i]] = 1;
            count++;
        }
        if (count == k) {
            return operations;
        }
    }
    return operations;
}