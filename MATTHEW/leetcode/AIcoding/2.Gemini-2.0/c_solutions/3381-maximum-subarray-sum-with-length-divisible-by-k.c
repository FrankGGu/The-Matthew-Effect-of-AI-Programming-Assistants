#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSubarraySumDivisibleByK(int* nums, int numsSize, int k) {
    int* prefix_rem = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        prefix_rem[i] = -1;
    }
    prefix_rem[0] = 0;
    int max_len = 0;
    int curr_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        curr_sum += nums[i];
        int rem = curr_sum % k;
        if (rem < 0) {
            rem += k;
        }
        if (prefix_rem[rem] == -1) {
            prefix_rem[rem] = i + 1;
        } else {
            max_len = (i + 1 - prefix_rem[rem] > max_len) ? (i + 1 - prefix_rem[rem]) : max_len;
        }
    }
    free(prefix_rem);
    return max_len;
}