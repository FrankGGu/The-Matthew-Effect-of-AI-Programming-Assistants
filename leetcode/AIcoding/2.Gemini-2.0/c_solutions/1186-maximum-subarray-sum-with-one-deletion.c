#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximum(int a, int b) {
    return (a > b) ? a : b;
}

int maximumSubarraySum(int* nums, int numsSize){
    if (numsSize == 0) return 0;

    int* dp_no_deletion = (int*)malloc(numsSize * sizeof(int));
    int* dp_one_deletion_left = (int*)malloc(numsSize * sizeof(int));
    int* dp_one_deletion_right = (int*)malloc(numsSize * sizeof(int));

    dp_no_deletion[0] = nums[0];
    dp_one_deletion_left[0] = 0;

    int max_so_far = nums[0];

    for (int i = 1; i < numsSize; i++) {
        dp_no_deletion[i] = maximum(nums[i], dp_no_deletion[i - 1] + nums[i]);
        max_so_far = maximum(max_so_far, dp_no_deletion[i]);
        dp_one_deletion_left[i] = maximum(dp_one_deletion_left[i-1] + nums[i], dp_no_deletion[i-1]);
        max_so_far = maximum(max_so_far, dp_one_deletion_left[i]);
    }

    dp_one_deletion_right[numsSize-1] = 0;

    for (int i = numsSize - 2; i >= 0; i--) {
        dp_one_deletion_right[i] = maximum(dp_one_deletion_right[i+1] + nums[i], dp_no_deletion[i+1]);
    }

    for(int i=1; i<numsSize-1; i++){
        max_so_far = maximum(max_so_far, dp_one_deletion_right[i+1] + dp_no_deletion[i-1]);
    }

    free(dp_no_deletion);
    free(dp_one_deletion_left);
    free(dp_one_deletion_right);

    return max_so_far;
}