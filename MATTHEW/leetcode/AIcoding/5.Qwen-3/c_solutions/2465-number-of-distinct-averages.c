#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int distinctAverages(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int* averages = (int*)malloc(sizeof(int) * (numsSize / 2));
    int count = 0;
    for (int i = 0; i < numsSize / 2; i++) {
        int avg = (nums[i] + nums[numsSize - 1 - i]) / 2;
        int isUnique = 1;
        for (int j = 0; j < count; j++) {
            if (averages[j] == avg) {
                isUnique = 0;
                break;
            }
        }
        if (isUnique) {
            averages[count++] = avg;
        }
    }
    free(averages);
    return count;
}