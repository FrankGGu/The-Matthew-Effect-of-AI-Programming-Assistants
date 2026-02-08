#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* getClosestSubsequenceSum(int* nums, int numsSize, int target, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;
    result[0] = 0;
    result[1] = 0;

    int n = numsSize;
    int* left = (int*)malloc(sizeof(int) * (1 << (n / 2)));
    int* right = (int*)malloc(sizeof(int) * (1 << (n - n / 2)));

    int leftSize = 0;
    for (int mask = 0; mask < (1 << (n / 2)); mask++) {
        int sum = 0;
        for (int i = 0; i < (n / 2); i++) {
            if (mask & (1 << i)) {
                sum += nums[i];
            }
        }
        left[leftSize++] = sum;
    }

    int rightSize = 0;
    for (int mask = 0; mask < (1 << (n - n / 2)); mask++) {
        int sum = 0;
        for (int i = 0; i < (n - n / 2); i++) {
            if (mask & (1 << i)) {
                sum += nums[n / 2 + i];
            }
        }
        right[rightSize++] = sum;
    }

    qsort(left, leftSize, sizeof(int), compare);
    qsort(right, rightSize, sizeof(int), compare);

    int i = 0;
    int j = rightSize - 1;
    int minDiff = abs(left[0] + right[0] - target);
    result[0] = left[0];
    result[1] = right[0];

    while (i < leftSize && j >= 0) {
        int currentSum = left[i] + right[j];
        int diff = abs(currentSum - target);
        if (diff < minDiff) {
            minDiff = diff;
            result[0] = left[i];
            result[1] = right[j];
        }

        if (currentSum < target) {
            i++;
        } else {
            j--;
        }
    }

    return result;
}