#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minScore(int* nums, int numsSize){
    if (numsSize <= 2) {
        return 0;
    }

    int min1 = nums[0];
    int min2 = nums[1] < nums[0] ? nums[1] : nums[0];
    int max1 = nums[0];
    int max2 = nums[numsSize - 1] > nums[0] ? nums[numsSize - 1] : nums[0];

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < min1) {
            min2 = min1;
            min1 = nums[i];
        } else if (nums[i] < min2) {
            min2 = nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max1) {
            max2 = max1;
            max1 = nums[i];
        } else if (nums[i] > max2) {
            max2 = nums[i];
        }
    }

    int ans1 = max1 - min1;

    int temp_nums[numsSize];
    for (int i = 0; i < numsSize; i++) {
        temp_nums[i] = nums[i];
    }
    temp_nums[0] = temp_nums[numsSize - 1];

    int min_temp1 = temp_nums[0];
    int min_temp2 = temp_nums[1] < temp_nums[0] ? temp_nums[1] : temp_nums[0];
    int max_temp1 = temp_nums[0];
    int max_temp2 = temp_nums[numsSize - 1] > temp_nums[0] ? temp_nums[numsSize - 1] : temp_nums[0];

    for (int i = 0; i < numsSize; i++) {
        if (temp_nums[i] < min_temp1) {
            min_temp2 = min_temp1;
            min_temp1 = temp_nums[i];
        } else if (temp_nums[i] < min_temp2) {
            min_temp2 = temp_nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (temp_nums[i] > max_temp1) {
            max_temp2 = max_temp1;
            max_temp1 = temp_nums[i];
        } else if (temp_nums[i] > max_temp2) {
            max_temp2 = temp_nums[i];
        }
    }

    int ans2 = max_temp1 - min_temp1;

    for (int i = 0; i < numsSize; i++) {
        temp_nums[i] = nums[i];
    }

    temp_nums[numsSize-1] = temp_nums[0];

    min_temp1 = temp_nums[0];
    min_temp2 = temp_nums[1] < temp_nums[0] ? temp_nums[1] : temp_nums[0];
    max_temp1 = temp_nums[0];
    max_temp2 = temp_nums[numsSize - 1] > temp_nums[0] ? temp_nums[numsSize - 1] : temp_nums[0];

    for (int i = 0; i < numsSize; i++) {
        if (temp_nums[i] < min_temp1) {
            min_temp2 = min_temp1;
            min_temp1 = temp_nums[i];
        } else if (temp_nums[i] < min_temp2) {
            min_temp2 = temp_nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (temp_nums[i] > max_temp1) {
            max_temp2 = max_temp1;
            max_temp1 = temp_nums[i];
        } else if (temp_nums[i] > max_temp2) {
            max_temp2 = temp_nums[i];
        }
    }

    int ans3 = max_temp1 - min_temp1;

    int result = ans1 < ans2 ? ans1 : ans2;
    result = result < ans3 ? result : ans3;

    return result;
}