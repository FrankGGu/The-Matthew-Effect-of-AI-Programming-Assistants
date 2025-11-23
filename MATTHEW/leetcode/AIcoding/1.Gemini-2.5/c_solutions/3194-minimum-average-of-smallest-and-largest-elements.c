#include <stdlib.h>
#include <math.h>
#include <float.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

double minimumAverage(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    double min_avg = DBL_MAX;

    for (int i = 0; i < numsSize / 2; i++) {
        double current_avg = (double)(nums[i] + nums[numsSize - 1 - i]) / 2.0;
        if (current_avg < min_avg) {
            min_avg = current_avg;
        }
    }

    return min_avg;
}