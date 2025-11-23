#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    int idx;
} Pair;

int* shortestSubarray(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    long long prefix[n + 1];
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = n;
    int minLen = n + 1;

    int* dq = (int*)malloc((n + 1) * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i <= n; i++) {
        while (front < rear && prefix[i] - prefix[dq[front]] >= k) {
            int len = i - dq[front];
            if (len < minLen) {
                minLen = len;
                result[0] = dq[front];
                result[1] = i;
            }
            front++;
        }

        while (front < rear && prefix[i] <= prefix[dq[rear - 1]]) {
            rear--;
        }

        dq[rear++] = i;
    }

    if (minLen != n + 1) {
        *returnSize = 2;
        return result;
    } else {
        *returnSize = 0;
        free(result);
        return NULL;
    }
}