#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProduct(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int max_prod = nums[0];
    int min_prod = nums[0];
    int result = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int temp_max = max_prod;
        max_prod = (nums[i] > max_prod * nums[i]) ? 
                   (nums[i] > min_prod * nums[i] ? nums[i] : min_prod * nums[i]) :
                   (max_prod * nums[i] > min_prod * nums[i] ? max_prod * nums[i] : min_prod * nums[i]);

        min_prod = (nums[i] < min_prod * nums[i]) ?
                   (nums[i] < temp_max * nums[i] ? nums[i] : temp_max * nums[i]) :
                   (min_prod * nums[i] < temp_max * nums[i] ? min_prod * nums[i] : temp_max * nums[i]);

        if (max_prod > result) {
            result = max_prod;
        }
    }

    return result;
}

int maxSubarrayLength(int* nums, int numsSize) {
    if (numsSize <= 1) return numsSize;

    int max_len = 1;

    for (int i = 0; i < numsSize; i++) {
        long long product = nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            product *= nums[j];
            if (product == (long long)nums[i] * nums[j]) {
                if (j - i + 1 > max_len) {
                    max_len = j - i + 1;
                }
            } else {
                break;
            }
        }
    }

    return max_len;
}