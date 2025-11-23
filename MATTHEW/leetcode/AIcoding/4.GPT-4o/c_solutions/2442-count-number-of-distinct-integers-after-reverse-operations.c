#include <stdio.h>
#include <stdlib.h>

int countDistinctIntegers(int* nums, int numsSize) {
    int* set = (int*)calloc(1000000, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        set[nums[i]] = 1;
        int reversed = 0, original = nums[i];
        while (original > 0) {
            reversed = reversed * 10 + original % 10;
            original /= 10;
        }
        set[reversed] = 1;
    }

    int count = 0;
    for (int i = 0; i < 1000000; i++) {
        if (set[i]) {
            count++;
        }
    }

    free(set);
    return count;
}