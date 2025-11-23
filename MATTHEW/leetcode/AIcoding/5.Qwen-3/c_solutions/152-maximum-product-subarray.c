#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxProduct(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int maxProd = nums[0];
    int minProd = nums[0];
    int result = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int num = nums[i];
        if (num < 0) {
            int temp = maxProd;
            maxProd = minProd;
            minProd = temp;
        }
        maxProd = fmax(num, maxProd * num);
        minProd = fmin(num, minProd * num);
        result = fmax(result, maxProd);
    }

    return result;
}