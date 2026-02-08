#include <stdio.h>
#include <stdlib.h>

int* slidingWindowMaximum(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    int* result = (int*)malloc(sizeof(int) * (n - k + 1));
    *returnSize = n - k + 1;

    int* dq = (int*)malloc(sizeof(int) * n);
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        while (front < rear && nums[i] >= nums[dq[rear - 1]]) {
            rear--;
        }
        dq[rear++] = i;

        if (dq[front] <= i - k) {
            front++;
        }

        if (i >= k - 1) {
            result[i - k + 1] = nums[dq[front]];
        }
    }

    free(dq);
    return result;
}