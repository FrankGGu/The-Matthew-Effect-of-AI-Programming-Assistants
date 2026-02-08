#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

double findMedian(int arr[], int k) {
    if (k % 2 == 0) {
        return ((double)arr[k / 2 - 1] + (double)arr[k / 2]) / 2.0;
    } else {
        return (double)arr[k / 2];
    }
}

double* medianSlidingWindow(int* nums, int numsSize, int k, int* returnSize){
    *returnSize = numsSize - k + 1;
    double* result = (double*)malloc((*returnSize) * sizeof(double));
    int* window = (int*)malloc(k * sizeof(int));

    for (int i = 0; i < k; i++) {
        window[i] = nums[i];
    }
    qsort(window, k, sizeof(int), compare);
    result[0] = findMedian(window, k);

    for (int i = 1; i <= numsSize - k; i++) {

        int oldVal = nums[i - 1];
        int newVal = nums[i + k - 1];

        int* tempWindow = (int*)malloc(k * sizeof(int));
        for(int j=0; j<k; j++) tempWindow[j] = window[j];

        int oldIndex = -1;
        for (int j = 0; j < k; j++) {
            if (tempWindow[j] == oldVal) {
                oldIndex = j;
                break;
            }
        }
        if(oldIndex == -1){
            for (int j = 0; j < k; j++) {
                if (nums[i-1] == nums[i+k-1] && nums[i-1] == tempWindow[j] ) {
                    oldIndex = j;
                    break;
                }
            }
        }

        window[oldIndex] = newVal;
        qsort(window, k, sizeof(int), compare);
        result[i] = findMedian(window, k);

        free(tempWindow);
    }

    free(window);
    return result;
}