#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int distinctAverages(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int count = 0;
    int i = 0, j = numsSize - 1;
    int averages[100];
    int avg_count = 0;

    while (i < j) {
        double avg = (double)(nums[i] + nums[j]) / 2.0;
        int found = 0;
        for (int k = 0; k < avg_count; k++) {
            if (fabs((double)averages[k] - avg) < 1e-6) {
                found = 1;
                break;
            }
        }
        if (!found) {
            averages[avg_count++] = (int)(avg * 1000);
            count++;
        }
        i++;
        j--;
    }
    return count;
}