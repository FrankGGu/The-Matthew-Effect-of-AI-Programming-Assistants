#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestSubarray(int* nums, int numsSize, int k) {
    int minLen = numsSize + 1;
    long long prefixSum[numsSize + 1];
    prefixSum[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    int deque[numsSize + 1];
    int head = 0, tail = 0;

    for (int i = 0; i <= numsSize; i++) {
        while (head < tail && prefixSum[i] - prefixSum[deque[head]] >= k) {
            int len = i - deque[head];
            if (len < minLen) {
                minLen = len;
            }
            head++;
        }

        while (head < tail && prefixSum[i] <= prefixSum[deque[tail - 1]]) {
            tail--;
        }

        deque[tail++] = i;
    }

    return minLen > numsSize ? -1 : minLen;
}