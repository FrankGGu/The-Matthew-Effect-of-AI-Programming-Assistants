#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDistinctIntegers(int* nums, int numsSize) {
    int* hash = (int*)calloc(1000000, sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int rev = 0;
        int temp = num;
        while (temp > 0) {
            rev = rev * 10 + temp % 10;
            temp /= 10;
        }
        if (hash[num] == 0) {
            count++;
            hash[num] = 1;
        }
        if (hash[rev] == 0) {
            count++;
            hash[rev] = 1;
        }
    }

    free(hash);
    return count;
}