#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maxSlidingWindow(int* nums, int numsSize, int k, int* returnSize){
    if (numsSize == 0 || k == 0) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));

    int* deque = (int*)malloc(sizeof(int) * numsSize);
    int head = 0;
    int tail = -1;

    for (int i = 0; i < numsSize; i++) {
        while (head <= tail && nums[deque[tail]] <= nums[i]) {
            tail--;
        }

        deque[++tail] = i;

        if (deque[head] < i - k + 1) {
            head++;
        }

        if (i >= k - 1) {
            result[i - k + 1] = nums[deque[head]];
        }
    }

    free(deque);
    return result;
}