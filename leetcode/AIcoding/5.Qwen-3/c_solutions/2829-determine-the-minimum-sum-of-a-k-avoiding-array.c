#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int kAvoidingArray(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= k) {
            sum += k + 1;
            k++;
        } else {
            sum += nums[i];
        }
    }
    return sum;
}