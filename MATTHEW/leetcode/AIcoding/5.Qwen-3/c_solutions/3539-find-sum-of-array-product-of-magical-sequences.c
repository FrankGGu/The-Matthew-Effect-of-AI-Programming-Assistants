#include <stdio.h>
#include <stdlib.h>

long long sumOfArrayProduct(int* nums, int numsSize) {
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        long long product = 1;
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                product *= nums[j];
            }
        }
        total += product;
    }
    return total;
}