#include <stdio.h>
#include <stdlib.h>

int* minAverageDifference(int* nums, int numsSize, int* returnSize) {
    int n = numsSize;
    int* result = (int*)malloc(sizeof(int) * n);
    int* prefix = (int*)malloc(sizeof(int) * n);

    prefix[0] = nums[0];
    for (int i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    int minIndex = 0;
    double minAvgDiff = 1e9;

    for (int i = 0; i < n; i++) {
        double leftAvg = (double)prefix[i] / (i + 1);
        double rightAvg = (i == n - 1) ? 0 : (double)(prefix[n - 1] - prefix[i]) / (n - i - 1);
        double diff = fabs(leftAvg - rightAvg);

        if (diff < minAvgDiff) {
            minAvgDiff = diff;
            minIndex = i;
        }
    }

    result[0] = minIndex;
    *returnSize = 1;
    free(prefix);
    return result;
}