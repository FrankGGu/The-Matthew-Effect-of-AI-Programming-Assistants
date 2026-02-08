#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canPartition(int* nums, int numsSize) {
    long long totalProduct = 1;
    int zeroCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            zeroCount++;
        } else {
            totalProduct *= nums[i];
        }
    }

    if (zeroCount > 0) return true;
    if (totalProduct == 1) return true;

    long long subsetProduct = 1;
    for (int i = 0; i < (1 << numsSize); i++) {
        subsetProduct = 1;
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                if (nums[j] == 0) {
                    subsetProduct = 0;
                    break;
                } else {
                    subsetProduct *= nums[j];
                }
                count++;
            }
        }

        if (subsetProduct == 0) continue;
        if (totalProduct % subsetProduct == 0) {
            long long otherProduct = totalProduct / subsetProduct;
            if (subsetProduct == otherProduct && count > 0 && count < numsSize) return true;

        }

    }

    return false;
}