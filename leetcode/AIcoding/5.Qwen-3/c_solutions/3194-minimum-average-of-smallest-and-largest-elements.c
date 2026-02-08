#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

double initialAverage(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    double avg = (nums[0] + nums[numsSize - 1]) / 2.0;
    return avg;
}

double findMinAverage(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    double minAvg = (nums[0] + nums[numsSize - 1]) / 2.0;
    for (int i = 1; i < numsSize - 1; i++) {
        double avg = (nums[i] + nums[numsSize - 1 - i]) / 2.0;
        if (avg < minAvg) {
            minAvg = avg;
        }
    }
    return minAvg;
}