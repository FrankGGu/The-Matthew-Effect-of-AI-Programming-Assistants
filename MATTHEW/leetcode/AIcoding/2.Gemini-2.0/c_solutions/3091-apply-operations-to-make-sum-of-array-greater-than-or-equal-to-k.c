#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int*)b) - (*(int*)a);
}

int minOperations(int* nums, int numsSize, int k) {
    int setBits = 0;
    for (int i = 0; i < numsSize; i++) {
        setBits += countSetBits(nums[i]);
    }

    if (setBits >= k) {
        return 0;
    }

    int ones[numsSize];
    int onesSize = 0;
    for (int i = 0; i < numsSize; i++) {
        ones[onesSize++] = nums[i];
    }

    qsort(ones, onesSize, sizeof(int), cmp);

    int operations = 0;
    for (int i = 0; i < onesSize; i++) {
        setBits += countSetBits(ones[i]);
        operations++;
        if (setBits >= k) {
            return operations;
        }
    }

    return operations;
}