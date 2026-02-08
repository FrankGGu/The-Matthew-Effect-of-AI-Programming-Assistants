#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long findTheArrayConcVal(int* nums, int numsSize) {
    long long sum = 0;
    int left = 0, right = numsSize - 1;
    while (left <= right) {
        if (left == right) {
            sum += nums[left];
            break;
        } else {
            char str1[12];
            char str2[12];
            sprintf(str1, "%d", nums[left]);
            sprintf(str2, "%d", nums[right]);
            char combined[24];
            strcpy(combined, str1);
            strcat(combined, str2);
            sum += atoll(combined);
            left++;
            right--;
        }
    }
    return sum;
}