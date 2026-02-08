#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxGoodSubarraySum(int* nums, int numsSize, int k) {
    long long max_sum = LLONG_MIN;
    long long prefix_sum = 0;
    int min_prefix_sum_index = -1;
    long long min_prefix_sum = LLONG_MAX;

    for (int i = 0; i < numsSize; i++) {
        prefix_sum += nums[i];

        if (abs(nums[i]) >= k) {
            if (prefix_sum - min_prefix_sum > max_sum) {
                max_sum = prefix_sum - min_prefix_sum;
            }
        }
        if(prefix_sum < min_prefix_sum){
            min_prefix_sum = prefix_sum;
        }
    }

    long long max_element = LLONG_MIN;
    for(int i = 0; i < numsSize; i++){
        if(abs(nums[i]) >= k && nums[i] > max_element){
            max_element = nums[i];
        }
    }
    if(max_sum == LLONG_MIN){
        return max_element;
    }

    if(max_element > max_sum && max_element >= 0){
        return max_element;
    }

    return max_sum;
}