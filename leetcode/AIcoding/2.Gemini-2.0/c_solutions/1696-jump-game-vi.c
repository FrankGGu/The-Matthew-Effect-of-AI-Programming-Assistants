#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxResult(int* nums, int numsSize, int k) {
    int *dp = (int*)malloc(sizeof(int) * numsSize);
    dp[0] = nums[0];

    int *deque = (int*)malloc(sizeof(int) * numsSize);
    int head = 0, tail = 0;
    deque[0] = 0;

    for (int i = 1; i < numsSize; i++) {
        while (head <= tail && deque[head] < i - k) {
            head++;
        }

        dp[i] = dp[deque[head]] + nums[i];

        while (head <= tail && dp[deque[tail]] <= dp[i]) {
            tail--;
        }

        deque[++tail] = i;
    }

    int result = dp[numsSize - 1];
    free(dp);
    free(deque);
    return result;
}