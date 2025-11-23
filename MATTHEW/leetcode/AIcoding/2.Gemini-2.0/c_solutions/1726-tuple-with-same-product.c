#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tupleSameProduct(int* nums, int numsSize) {
    int count = 0;
    int hash[200001] = {0};

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int product = nums[i] * nums[j];
            count += hash[product] * 8;
            hash[product]++;
        }
    }

    return count;
}