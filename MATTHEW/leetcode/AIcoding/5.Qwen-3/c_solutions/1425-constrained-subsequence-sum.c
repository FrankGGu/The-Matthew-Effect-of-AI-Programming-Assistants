#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int* constrainedSubsequenceSum(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* dq = (int*)malloc(numsSize * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < numsSize; i++) {
        int current = nums[i];
        if (front < rear && dq[front] < i - k) {
            front++;
        }
        int prev = (front < rear) ? result[dq[front]] : 0;
        result[i] = prev + current;

        while (front < rear && result[i] >= result[dq[rear - 1]]) {
            rear--;
        }
        dq[rear++] = i;
    }

    *returnSize = numsSize;
    return result;
}