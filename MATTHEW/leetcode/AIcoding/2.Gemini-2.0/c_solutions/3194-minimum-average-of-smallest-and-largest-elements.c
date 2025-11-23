#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double minimumAverage(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0.0;
    }

    double minAvg = (double)(nums[0] + nums[1]) / 2.0;
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int minVal = nums[i];
            int maxVal = nums[i];
            for (int k = i; k <= j; k++) {
                if (nums[k] < minVal) {
                    minVal = nums[k];
                }
                if (nums[k] > maxVal) {
                    maxVal = nums[k];
                }
            }
            double avg = (double)(minVal + maxVal) / 2.0;
            if (avg < minAvg) {
                minAvg = avg;
            }
        }
    }
    return minAvg;
}