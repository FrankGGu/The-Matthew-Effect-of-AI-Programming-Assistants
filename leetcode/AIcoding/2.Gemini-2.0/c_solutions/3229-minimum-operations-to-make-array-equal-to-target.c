#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int target) {
    int operations = 0;
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum < target) {
        return -1;
    }

    int i = 0;
    while (i < numsSize && nums[i] == 1) {
        i++;
    }

    if (i == numsSize && target > numsSize) {
        return -1;
    }

    long long current_sum = 0;
    int j = 0;
    while(current_sum < target){
        current_sum += nums[j];
        j++;
    }

    if(current_sum == target){
        return j - 1;
    }

    current_sum -= nums[j-1];
    j--;

    int remaining_sum = current_sum;
    int start_index = j;

    while(remaining_sum != target){
        if(nums[j] == 0){
            j--;
        } else {
            if(remaining_sum + 1 <= target){
                remaining_sum += 1;
                operations++;
            } else {
                remaining_sum -= nums[j];
                nums[j] = 0;
                operations++;

            }
        }
    }

    return operations;
}