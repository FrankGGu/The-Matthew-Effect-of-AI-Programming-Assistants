#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int abs_val(int a) {
    return a > 0 ? a : -a;
}

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int minAbsDifference(int* nums, int numsSize, int goal) {
    int n = numsSize;
    int leftSize = n / 2;
    int rightSize = n - leftSize;

    int leftSumsSize = 1 << leftSize;
    int* leftSums = (int*)malloc(leftSumsSize * sizeof(int));
    for (int i = 0; i < leftSumsSize; i++) {
        int sum = 0;
        for (int j = 0; j < leftSize; j++) {
            if ((i >> j) & 1) {
                sum += nums[j];
            }
        }
        leftSums[i] = sum;
    }

    int rightSumsSize = 1 << rightSize;
    int* rightSums = (int*)malloc(rightSumsSize * sizeof(int));
    for (int i = 0; i < rightSumsSize; i++) {
        int sum = 0;
        for (int j = 0; j < rightSize; j++) {
            if ((i >> j) & 1) {
                sum += nums[leftSize + j];
            }
        }
        rightSums[i] = sum;
    }

    qsort(rightSums, rightSumsSize, sizeof(int), compare);

    int minDiff = INT_MAX;
    for (int i = 0; i < leftSumsSize; i++) {
        int complement = goal - leftSums[i];
        int left = 0, right = rightSumsSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            minDiff = (abs_val(rightSums[mid] + leftSums[i] - goal) < minDiff) ? abs_val(rightSums[mid] + leftSums[i] - goal) : minDiff;
            if (rightSums[mid] < complement) {
                left = mid + 1;
            } else if (rightSums[mid] > complement) {
                right = mid - 1;
            } else {
                minDiff = 0;
                break;
            }
        }
        if (minDiff == 0) break;
    }

    free(leftSums);
    free(rightSums);

    return minDiff;
}